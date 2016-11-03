package dk.danskebank.mobilepayfruitshop;

import android.app.AlertDialog;
import android.app.ListActivity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ListView;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.UUID;

import dk.danskebank.mobilepay.sdk.CaptureType;
import dk.danskebank.mobilepay.sdk.Country;
import dk.danskebank.mobilepay.sdk.MobilePay;
import dk.danskebank.mobilepay.sdk.ResultCallback;
import dk.danskebank.mobilepay.sdk.model.FailureResult;
import dk.danskebank.mobilepay.sdk.model.Payment;
import dk.danskebank.mobilepay.sdk.model.SuccessResult;

public class MainActivity extends ListActivity {
    private static final int MOBILEPAY_PAYMENT_REQUEST_CODE = 1337;
    private ProductAdapter adapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Initialize the AppSwitch SDK with your own Merchant ID. A country can also be provided to target specific MobilePay apps (default is DK). It is important that init() is called before everything else since it resets all settings.
        MobilePay.getInstance().init(getString(R.string.merchant_id_generic), Country.DENMARK);

        // The AppSwitch SDK has some global settings. These can be used to tweak the payment flow if needed. None of these are required.
        tweakPaymentSettings();

        // Create some dummy items and setup the list adapter.
        ArrayList<Product> products = new ArrayList<>();
        products.add(new Product(getString(R.string.product_name_orange), new BigDecimal(10), R.drawable.orange));
        products.add(new Product(getString(R.string.product_name_kiwi), new BigDecimal(0.56), R.drawable.kiwi));
        products.add(new Product(getString(R.string.product_name_strawberry), new BigDecimal(4.43), R.drawable.strawberry));
        products.add(new Product(getString(R.string.product_name_basket), new BigDecimal(1501.52), R.drawable.fruit_basket));

        adapter = new ProductAdapter(this, products);

        setListAdapter(adapter);
    }

    private void tweakPaymentSettings() {
        // Determines which type of payment you would like to start. CAPTURE, RESERVE and PARTIAL CAPTURE are the possibilities. CAPTURE is default. See the GitHub wiki for more information on each type.
        MobilePay.getInstance().setCaptureType(CaptureType.CAPTURE);
        // Set the number of seconds from the MobilePay receipt are shown to the user returns to the merchant app. Default is 1.
        MobilePay.getInstance().setReturnSeconds(1);
        // Set the number of seconds the user has to complete the payment. Default is 0, which is no timeout.
        MobilePay.getInstance().setTimeoutSeconds(0);
    }

    @Override
    protected void onListItemClick(ListView l, View v, int position, long id) {
        super.onListItemClick(l, v, position, id);

        // Get product from the list.
        Product product = adapter.getItem(position);

        // Create a new MobilePay Payment object.
        Payment payment = new Payment();

        // Set the product price.
        payment.setProductPrice(product.getPrice());

        // Set BulkRef for this payment. Payments will be grouped under this tag.
        payment.setBulkRef(getString(R.string.product_group));

        // Set the order ID. This is your reference and should match your business case. Has to be unique.
        payment.setOrderId(UUID.randomUUID().toString());

        // Have the SDK create an Intent with the Payment object specified.
        Intent paymentIntent = MobilePay.getInstance().createPaymentIntent(payment);

        // Query the SDK to see if MobilePay is present on the system.
        boolean isMobilePayInstalled = MobilePay.getInstance().isMobilePayInstalled(getApplicationContext());

        // If we determine that MobilePay is installed we start an AppSwitch payment, else we could lead the user to Google Play to download the app.
        if (isMobilePayInstalled) {
            // Call startActivityForResult with the Intent and a specific request code of your choice. Wait for the selected request code in OnActivityResult.
            startActivityForResult(paymentIntent, MOBILEPAY_PAYMENT_REQUEST_CODE);
        } else {
            // Inform the user that MobilePay is not installed and lead them to Google Play.
            downloadMobilePayApp();
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == MOBILEPAY_PAYMENT_REQUEST_CODE) {
            // We received a payment response matching our request code.

            // We call the AppSwitch SDK with resultCode and data. The SDK will handle any validation if needed and determine if the payment succeeded.
            MobilePay.getInstance().handleResult(resultCode, data, new ResultCallback() {
                @Override
                public void onSuccess(SuccessResult result) {
                    // The payment succeeded. SuccessResult object holds further information.

                    // The product can now be delivered to the customer.

                    showPaymentResultDialog(getString(R.string.payment_result_dialog_success_title), getString(R.string.payment_result_dialog_success_message, result.getTransactionId()));
                }

                @Override
                public void onFailure(FailureResult result) {
                    // The payment failed. FailureResult object holds further information.

                    // You should inform the user why the error happened. See the list of possible error codes for more information.

                    // Example of how to catch a specific MobilePay error code.
                    if (result.getErrorCode() == MobilePay.ERROR_RESULT_CODE_UPDATE_APP) {
                        // Notify the user to update MobilePay.
                        showPaymentResultDialog(getString(R.string.payment_result_dialog_error_update_title), getString(R.string.payment_result_dialog_error_update_message));
                        return;
                    }

                    showPaymentResultDialog(getString(R.string.payment_result_dialog_error_title, String.valueOf(result.getErrorCode())), result.getErrorMessage());
                }

                @Override
                public void onCancel() {
                    // The payment was cancelled, which means the user jumped back from MobilePay before processing the payment.
                    showPaymentResultDialog(getString(R.string.payment_result_dialog_cancelled_title), getString(R.string.payment_result_dialog_cancelled_message));
                }
            });
        }
    }

    private void showPaymentResultDialog(String title, String content) {
        // In this demo app we show a simple dialog with information of the transaction.
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(title)
                .setMessage(content)
                .setPositiveButton(getString(R.string.payment_result_dialog_positive), null);
        AlertDialog dialog = builder.create();
        dialog.show();
    }

    private void downloadMobilePayApp() {
        // Simple dialog informing the user about the missing MobilePay app and offering them to install it from Google Play.
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle(getString(R.string.install_mobilepay_dialog_title))
                .setMessage(getString(R.string.install_mobilepay_dialog_message))
                .setPositiveButton(getString(R.string.install_mobilepay_dialog_positive_text), new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        // Create a MobilePay download Intent.
                        Intent intent = MobilePay.getInstance().createDownloadMobilePayIntent(getApplicationContext());
                        startActivity(intent);
                    }
                })
                .setNegativeButton(getString(R.string.install_mobilepay_dialog_negative_text), null);
        AlertDialog dialog = builder.create();
        dialog.show();
    }
}