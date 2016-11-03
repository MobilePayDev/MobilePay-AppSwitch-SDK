package dk.danskebank.mobilepayfruitshop;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;

class ProductAdapter extends ArrayAdapter<Product> {
    private final Context context;
    private final int layoutResourceId;
    private final DecimalFormat priceFormat;
    private final ArrayList<Product> data;

    public ProductAdapter(Context context, ArrayList<Product> data) {
        super(context, R.layout.row_image_with_text, data);
        this.layoutResourceId = R.layout.row_image_with_text;
        this.context = context;
        this.data = data;

        priceFormat = new DecimalFormat();

        DecimalFormatSymbols symbols = priceFormat.getDecimalFormatSymbols();
        symbols.setDecimalSeparator(',');
        symbols.setGroupingSeparator('.');
        priceFormat.setDecimalFormatSymbols(symbols);
        priceFormat.setDecimalSeparatorAlwaysShown(true);
        priceFormat.setMinimumFractionDigits(2);
        priceFormat.setGroupingUsed(true);
        priceFormat.setGroupingSize(3);
        priceFormat.setNegativePrefix("-");
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View row = convertView;
        ProductHolder holder;

        if (row == null) {
            LayoutInflater inflater = LayoutInflater.from(context);
            row = inflater.inflate(layoutResourceId, parent, false);

            holder = new ProductHolder();
            holder.imgIcon = (ImageView) row.findViewById(R.id.img_fruit_icon);
            holder.txtName = (TextView) row.findViewById(R.id.txt_fruit_name);
            holder.txtPrice = (TextView) row.findViewById(R.id.txt_fruit_price);

            row.setTag(holder);
        } else {
            holder = (ProductHolder) row.getTag();
        }

        Product product = data.get(position);
        holder.imgIcon.setImageResource(product.getIcon());
        holder.txtName.setText(product.getName());
        String amount = priceFormat.format(product.getPrice().doubleValue());
        holder.txtPrice.setText(String.format(context.getString(R.string.product_price), amount));

        return row;
    }

    public static class ProductHolder {
        ImageView imgIcon;
        TextView txtName;
        TextView txtPrice;
    }
}
