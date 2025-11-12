using PhanHuyBinhWPF.Models;

namespace PhanHuyBinhWPF.Services
{
    public interface IUserSessionService
    {
        Customer? CurrentCustomer { get; }
        bool Login(string email, string password);
        void Logout();
    }
}