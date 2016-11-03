/*
  In App.xaml:
  <Application.Resources>
      <vm:ViewModelLocator xmlns:vm="clr-namespace:MobilePay.AppSwitchDemo"
                           x:Key="Locator" />
  </Application.Resources>
  
  In the View:
  DataContext="{Binding Source={StaticResource Locator}, Path=ViewModelName}"

  You can also use Blend to do all this with the tool's support.
  See http://www.galasoft.ch/mvvm
*/

using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.Ioc;
using Microsoft.Practices.ServiceLocation;
using MobilePay.AppSwitchDemo.Services;
using MobilePay;
using System;
using System.Diagnostics;
using System.Threading.Tasks;
using Windows.Storage;
using Windows.Storage.Streams;

namespace MobilePay.AppSwitchDemo.ViewModel
{
    /// <summary>
    /// This class contains static references to all the view models in the
    /// application and provides an entry point for the bindings.
    /// </summary>
    public class ViewModelLocator
    {
        /// <summary>
        /// Initializes a new instance of the ViewModelLocator class.
        /// </summary>
        public ViewModelLocator()
        {
            ServiceLocator.SetLocatorProvider(() => SimpleIoc.Default);

            SimpleIoc.Default.Register<IProductService, ProductService>();
            SimpleIoc.Default.Register<IPaymentResultHandler, PaymentResultHandler>();
            SimpleIoc.Default.Register<MainViewModel>();

            //Setup IMobilePayService for app switch
            SimpleIoc.Default.Register<IMobilePayService>(() =>
            {
                //The following configuration is only for this DEMO App.
                //Your app should use it own merchantId, successCallbackFileExtension and failureCallbackUrl.
                //Do not use "fruitshop" and "fruitshop:failure". Instead use for example for app name as the fileExtension and callback url. "shortappname" and "shortappname:failure".
                return new MobilePayService("APPDK0000000000", Country.Denmark, "fruitshop", "fruitshop:failure");
            });
        }

        public MainViewModel Main
        {
            get
            {
                return ServiceLocator.Current.GetInstance<MainViewModel>();
            }
        }

        public static void Cleanup()
        {
            // TODO Clear the ViewModels
        }
    }
}