IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'FUMiniHotelManagement')
BEGIN
    CREATE DATABASE FUMiniHotelManagement;
END
GO

USE FUMiniHotelManagement;
GO

-- Xóa bảng theo thứ tự đúng (từ con đến cha)
IF OBJECT_ID('dbo.BookingDetail', 'U') IS NOT NULL
    DROP TABLE dbo.BookingDetail;
GO

IF OBJECT_ID('dbo.BookingReservation', 'U') IS NOT NULL
    DROP TABLE dbo.BookingReservation;
GO

IF OBJECT_ID('dbo.RoomInformation', 'U') IS NOT NULL
    DROP TABLE dbo.RoomInformation;
GO

IF OBJECT_ID('dbo.Customer', 'U') IS NOT NULL
    DROP TABLE dbo.Customer;
GO

IF OBJECT_ID('dbo.RoomType', 'U') IS NOT NULL
    DROP TABLE dbo.RoomType;
GO

-- Tạo bảng theo thứ tự đúng (từ cha đến con)
CREATE TABLE dbo.Customer (
    CustomerID INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- Thêm IDENTITY
    CustomerFullName NVARCHAR(100),
    Telephone VARCHAR(20),
    EmailAddress VARCHAR(255),
    CustomerBirthday DATE,
    CustomerStatus NVARCHAR(50),
    Password NVARCHAR(255)
);
GO

CREATE TABLE dbo.RoomType (
    RoomTypeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- Thêm IDENTITY
    RoomTypeName NVARCHAR(100),
    TypeDescription NVARCHAR(500),
    TypeNote NVARCHAR(255)
);
GO

CREATE TABLE dbo.RoomInformation (
    RoomID INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- Thêm IDENTITY
    RoomNumber NVARCHAR(10),
    RoomDetailDescription NVARCHAR(MAX),
    RoomMaxCapacity INT,
    RoomTypeID INT,
    RoomStatus NVARCHAR(50),
    RoomPricePerDay DECIMAL(18, 2),
    
    CONSTRAINT FK_RoomInformation_RoomType FOREIGN KEY (RoomTypeID)
        REFERENCES dbo.RoomType(RoomTypeID)
);
GO

CREATE TABLE dbo.BookingReservation (
    BookingReservationID INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- Thêm IDENTITY
    BookingDate DATETIME,
    TotalPrice DECIMAL(18, 2),
    CustomerID INT,
    BookingStatus NVARCHAR(50),
    
    CONSTRAINT FK_BookingReservation_Customer FOREIGN KEY (CustomerID)
        REFERENCES dbo.Customer(CustomerID)
);
GO

CREATE TABLE dbo.BookingDetail (
    BookingReservationID INT NOT NULL,
    RoomID INT NOT NULL,
    StartDate DATE,
    EndDate DATE,
    ActualPrice DECIMAL(18, 2),
    
    CONSTRAINT PK_BookingDetail PRIMARY KEY (BookingReservationID, RoomID),
    
    CONSTRAINT FK_BookingDetail_BookingReservation FOREIGN KEY (BookingReservationID)
        REFERENCES dbo.BookingReservation(BookingReservationID),
    
    CONSTRAINT FK_BookingDetail_RoomInformation FOREIGN KEY (RoomID)
        REFERENCES dbo.RoomInformation(RoomID)
);
GO
INSERT INTO dbo.RoomType (RoomTypeName, TypeDescription, TypeNote)
VALUES
(N'Standard', N'Phòng tiêu chuẩn với 1 giường đôi hoặc 2 giường đơn, trang bị cơ bản.', N'Bao gồm ăn sáng buffet'),
(N'Deluxe', N'Phòng rộng rãi hơn, có cửa sổ lớn nhìn ra thành phố hoặc hồ bơi.', N'Miễn phí minibar ngày đầu'),
(N'Suite', N'Phòng hạng sang với phòng khách riêng, bồn tắm và dịch vụ cao cấp.', N'Có lối đi riêng và check-in ưu tiên'),
(N'Family', N'Phòng gia đình gồm 2 giường đôi, phù hợp cho 4 người.', N'Miễn phí cho trẻ em dưới 6 tuổi');
GO