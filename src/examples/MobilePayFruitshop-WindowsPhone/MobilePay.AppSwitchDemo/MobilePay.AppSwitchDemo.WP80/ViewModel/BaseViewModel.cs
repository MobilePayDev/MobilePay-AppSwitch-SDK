using GalaSoft.MvvmLight;
using GalaSoft.MvvmLight.Messaging;

namespace MobilePay.AppSwitchDemo.ViewModel
{
    public class BaseViewModel : ViewModelBase
    {
        public BaseViewModel()
        {
        }

        public BaseViewModel(IMessenger messenger)
            : base(messenger)
        {

        }
    }
}