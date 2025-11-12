using PhanHuyBinhWPF.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PhanHuyBinhWPF.Repositories
{
    public interface IBookingDetailRepository
    {
        void Add(BookingDetail b);
        void Delete(BookingDetail selectedDetail);
        IEnumerable<BookingDetail> GetByBookingId(int value);
    }
}
