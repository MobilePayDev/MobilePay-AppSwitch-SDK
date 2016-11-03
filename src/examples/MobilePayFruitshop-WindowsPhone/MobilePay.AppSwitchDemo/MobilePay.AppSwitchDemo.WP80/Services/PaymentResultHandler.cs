using MobilePay;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MobilePay.Models;

namespace MobilePay.AppSwitchDemo.Services
{
    public class PaymentResultHandler : IPaymentResultHandler
    {
        public async void Failure(FailureResult result)
        {
            var message = result.ErrorMessage;
            var title = string.Format("MobilePay Error {0}", (int)result.ErrorCode);
#if SILVERLIGHT
            System.Windows.MessageBox.Show(message, title, System.Windows.MessageBoxButton.OK);
#else
            var popup = new Windows.UI.Popups.MessageDialog(message, title);
            await popup.ShowAsync();
#endif
        }

        public async void Success(SuccessResult result)
        {
            var message = string.Format("You have now paid with MobilePay.\nYour MobilePay transactionId is '{0}'", result.TransactionId);
            var title = "MobilePay Succeeded";
#if SILVERLIGHT
            System.Windows.MessageBox.Show(message, title, System.Windows.MessageBoxButton.OK);
#else
            var popup = new Windows.UI.Popups.MessageDialog(message, title);
            await popup.ShowAsync();
#endif
        }

    }
}
