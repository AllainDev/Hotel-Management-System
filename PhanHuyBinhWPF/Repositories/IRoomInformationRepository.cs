using PhanHuyBinhWPF.Models;
using System.Collections.Generic;

namespace PhanHuyBinhWPF.Repositories
{
    public interface IRoomInformationRepository
    {
        List<RoomInformation> GetAvailableRooms();
        IEnumerable<RoomInformation> GetAllRooms();
        IEnumerable<RoomInformation> GetRoomsByNumber(string roomNumber);
        RoomInformation GetRoomById(int id);
        void AddRoom(RoomInformation room);
        void UpdateRoom(RoomInformation room);
        void DeleteRoom(int id);
        IEnumerable<RoomType> GetAllRoomTypes(); 

        bool IsRoomAvailable(int roomId, int customerId);
    }
}