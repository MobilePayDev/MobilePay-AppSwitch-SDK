using MobilePay.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MobilePay.AppSwitchDemo.Services
{
    public interface IPaymentResultHandler
    {
        void Failure(FailureResult result);
        void Success(SuccessResult result);
    }
}
