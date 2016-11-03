using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.Command;
using System;
using System.IO;
using System.Text;
using System.Collections.Generic;
using Windows.System;
using MobilePay.Models;
using MobilePay.Extensions;
using MobilePay;
using System.Windows;
using System.Threading.Tasks;
using MobilePay.AppSwitchDemo.Services;
using MobilePay.AppSwitchDemo.Models;

namespace MobilePay.AppSwitchDemo.ViewModel
{
    public class MainViewModel : BaseViewModel
    {
        private readonly IProductService productService;
        private readonly IMobilePayService mobilePayService;
        private readonly IPaymentResultHandler paymentResultHandler;

        public List<Product> Products { get; set; }

        public RelayCommand<Product> BuyProductCommand { get; set; }


        public MainViewModel(IProductService productService, IMobilePayService mobilePayService, IPaymentResultHandler paymentResultHandler)
        {
            this.productService = productService;
            this.mobilePayService = mobilePayService;
            this.paymentResultHandler = paymentResultHandler;

            BuyProductCommand = new RelayCommand<Product>(Buy);
            Products = new List<Product>(productService.GetAllProducts());
        }

        public async void Buy(Product product)
        {

            var payment = new Payment
            {
                //InstantCapture = false, //If InstantCapture is set to false, this will make a reservation of the money, instead of a instant capture/withdrawel
                OrderId = Guid.NewGuid().ToString(),
                ProductPrice = product.Price
            };

            var uri = mobilePayService.CreatePaymentLaunchUri(payment);

            await Launcher.LaunchUriAsync(uri);
        }

        public async void LoadFromQueryString(IDictionary<string, string> queryString)
        {
            await Task.Delay(300);
            await mobilePayService.PaymentResultHandler.HandlePaymentResultFromQueryStringAsync(queryString, paymentResultHandler.Success, paymentResultHandler.Failure);
        }
    }
}