
/*   
--------------------------------------------------------------------------------------------------------------------
	
	Author: Devendra Reddy Konasani
	SQL Server Version: Microsoft SQL Server 2012 (SP1) 
	History
	Date Created    Comments
	12/06/2024      Creating tables
--------------------------------------------------------------------------------------------------------------------
*/


CREATE DATABASE HotelManagementSystem_Team7;
GO
USE HotelManagementSystem_Team7;
GO

CREATE TABLE GUEST (
    GuestID INT NOT NULL IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Address VARCHAR(255),
    PRIMARY KEY (GuestID)
);

CREATE TABLE ROOM (
    RoomID INT NOT NULL IDENTITY(1,1),
    RoomNumber VARCHAR(10) NOT NULL,
    RoomType VARCHAR(50) NOT NULL,
    Rate DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    PRIMARY KEY (RoomID)
);

CREATE TABLE EMPLOYEE (
    EmployeeID INT NOT NULL IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    PRIMARY KEY (EmployeeID)
);

CREATE TABLE BOOKING (
    BookingID INT NOT NULL IDENTITY(1,1),
    GuestID INT NOT NULL,
    RoomID INT NOT NULL,
    CheckInDate DATE NOT NULL,
    CheckOutDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (BookingID),
    FOREIGN KEY (GuestID) REFERENCES GUEST(GuestID),
    FOREIGN KEY (RoomID) REFERENCES ROOM(RoomID)
);

CREATE TABLE PAYMENT (
    PaymentID INT NOT NULL IDENTITY(1,1),
    BookingID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    PRIMARY KEY (PaymentID),
    FOREIGN KEY (BookingID) REFERENCES BOOKING(BookingID)
);

CREATE TABLE SERVICE (
    ServiceID INT NOT NULL IDENTITY(1,1),
    ServiceName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (ServiceID)
);

CREATE TABLE SERVICE_BOOKING (
    ServiceBookingID INT NOT NULL IDENTITY(1,1),
    BookingID INT NOT NULL,
    ServiceID INT NOT NULL,
    ServiceDate DATE NOT NULL,
    Quantity INT NOT NULL,
    EmployeeID INT,
    PRIMARY KEY (ServiceBookingID),
    FOREIGN KEY (BookingID) REFERENCES BOOKING(BookingID),
    FOREIGN KEY (ServiceID) REFERENCES SERVICE(ServiceID),
    CONSTRAINT FK_ServiceBooking_Employee FOREIGN KEY (EmployeeID) REFERENCES EMPLOYEE(EmployeeID)
);

CREATE UNIQUE INDEX idx_email ON GUEST(Email);
CREATE UNIQUE INDEX idx_roomnumber ON ROOM(RoomNumber);
CREATE INDEX idx_status ON ROOM(Status);
CREATE INDEX idx_dates ON BOOKING(CheckInDate, CheckOutDate);
CREATE INDEX idx_paymentdate ON PAYMENT(PaymentDate);
CREATE INDEX idx_servicedate ON SERVICE_BOOKING(ServiceDate);
CREATE UNIQUE INDEX idx_employee_email ON EMPLOYEE(Email);



/*   
--------------------------------------------------------------------------------------------------------------------
	Team number: 7
	Author: Avinash Reddy Alla, Devendra Reddy Konasani
	Id: 1231965672, 1232253674
	Course: IFT/530
	SQL Server Version: Microsoft SQL Server 2012 (SP1) 
	History
	Date Created    Comments
	12/06/2024      Populating tables
--------------------------------------------------------------------------------------------------------------------
*/


GO

USE HotelManagementSystem_Team7;

-- Populate GUEST table (10 rows)
INSERT INTO GUEST (FirstName, LastName, Email, Phone, Address) VALUES
('Dev', 'Kumar', 'dev.kumar@email.com', '9876543210', 'Chennai'),
('Raghu', 'Reddy', 'raghu.reddy@email.com', '8765432109', 'Bangalore'),
('Sai', 'Krishna', 'sai.krishna@email.com', '7654321098', 'Hyderabad'),
('Avinash', 'Rao', 'avinash.rao@email.com', '6543210987', 'Mysore'),
('Priya', 'Nair', 'priya.nair@email.com', '5432109876', 'Kochi'),
('Karthik', 'Menon', 'karthik.menon@email.com', '4321098765', 'Trivandrum'),
('Lakshmi', 'Iyer', 'lakshmi.iyer@email.com', '3210987654', 'Coimbatore'),
('Vijay', 'Sharma', 'vijay.sharma@email.com', '2109876543', 'Madurai'),
('Ananya', 'Pillai', 'ananya.pillai@email.com', '1098765432', 'Vizag'),
('Ravi', 'Subramaniam', 'ravi.subramaniam@email.com', '9087654321', 'Mangalore');

-- Populate ROOM table (10 rows)
INSERT INTO ROOM (RoomNumber, RoomType, Rate, Status) VALUES
('101', 'Single', 1000.00, 'Available'),
('102', 'Double', 1500.00, 'Available'),
('103', 'Suite', 2500.00, 'Occupied'),
('201', 'Single', 1000.00, 'Available'),
('202', 'Double', 1500.00, 'Available'),
('203', 'Suite', 2500.00, 'Occupied'),
('301', 'Single', 1000.00, 'Available'),
('302', 'Double', 1500.00, 'Available'),
('303', 'Suite', 2500.00, 'Occupied'),
('401', 'Single', 1000.00, 'Available');

-- Populate EMPLOYEE table (10 rows)
INSERT INTO EMPLOYEE (FirstName, LastName, Position, Email, Phone) VALUES
('Rahul', 'Singh', 'Manager', 'rahul.singh@hotel.com', '9876543210'),
('Priya', 'Patel', 'Receptionist', 'priya.patel@hotel.com', '8765432109'),
('Amit', 'Sharma', 'Housekeeper', 'amit.sharma@hotel.com', '7654321098'),
('Neha', 'Gupta', 'Chef', 'neha.gupta@hotel.com', '6543210987'),
('Vikram', 'Reddy', 'Maintenance', 'vikram.reddy@hotel.com', '5432109876'),
('Anita', 'Desai', 'Concierge', 'anita.desai@hotel.com', '4321098765'),
('Rajesh', 'Kumar', 'Bellhop', 'rajesh.kumar@hotel.com', '3210987654'),
('Sneha', 'Verma', 'Bartender', 'sneha.verma@hotel.com', '2109876543'),
('Arjun', 'Nair', 'Security', 'arjun.nair@hotel.com', '1098765432'),
('Meera', 'Rao', 'Event Coordinator', 'meera.rao@hotel.com', '0987654321');

-- Populate BOOKING table (20 rows)
INSERT INTO BOOKING (GuestID, RoomID, CheckInDate, CheckOutDate, TotalAmount) VALUES
(1, 1, '2024-11-15', '2024-11-20', 5000.00),
(2, 2, '2024-11-16', '2024-11-21', 7500.00),
(3, 4, '2024-11-17', '2024-11-22', 5000.00),
(4, 5, '2024-11-18', '2024-11-23', 7500.00),
(5, 7, '2024-11-19', '2024-11-24', 5000.00),
(6, 8, '2024-11-20', '2024-11-25', 7500.00),
(7, 10, '2024-11-21', '2024-11-26', 5000.00),
(8, 1, '2024-11-22', '2024-11-27', 5000.00),
(9, 2, '2024-11-23', '2024-11-28', 7500.00),
(10, 4, '2024-11-24', '2024-11-29', 5000.00),
(1, 5, '2024-11-25', '2024-11-30', 7500.00),
(2, 7, '2024-11-26', '2024-12-01', 5000.00),
(3, 8, '2024-11-27', '2024-12-02', 7500.00),
(4, 10, '2024-11-28', '2024-12-03', 5000.00),
(5, 1, '2024-11-29', '2024-12-04', 5000.00),
(6, 2, '2024-11-30', '2024-12-05', 7500.00),
(7, 4, '2024-12-01', '2024-12-06', 5000.00),
(8, 3, '2024-12-03', '2024-12-08', 12500.00),
(9, 6, '2024-12-04', '2024-12-09', 12500.00),
(10, 9, '2024-12-05', '2024-12-10', 12500.00);

-- Populate PAYMENT table (20 rows)
INSERT INTO PAYMENT (BookingID, Amount, PaymentDate, PaymentMethod)
SELECT 
    BookingID,
    TotalAmount,
    CheckInDate,
    CASE BookingID % 3
        WHEN 0 THEN 'Credit Card'
        WHEN 1 THEN 'Debit Card'
        ELSE 'Cash'
    END AS PaymentMethod
FROM BOOKING;

-- Populate SERVICE table (10 rows)
INSERT INTO SERVICE (ServiceName, Description, Price) VALUES
('Room Service', 'In-room dining', 500.00),
('Laundry', 'Clothes washing and ironing', 300.00),
('Spa Treatment', 'Relaxing massage and therapy', 1500.00),
('Airport Transfer', 'Pick-up and drop-off service', 1000.00),
('Gym Access', 'Use of fitness facilities', 200.00),
('Concierge Service', 'Personalized assistance and recommendations', 250.00),
('Valet Parking', 'Car parking and retrieval service', 400.00),
('Business Center', 'Access to office equipment and meeting rooms', 600.00),
('Childcare Service', 'Supervised care for children', 800.00),
('Guided Tours', 'Local sightseeing with experienced guides', 1200.00);

-- Populate SERVICE_BOOKING table (30 rows)
INSERT INTO SERVICE_BOOKING (BookingID, ServiceID, ServiceDate, Quantity, EmployeeID) VALUES
(1, 1, '2024-11-16', 2, 3),
(2, 3, '2024-11-17', 1, 5),
(3, 2, '2024-11-18', 1, 2),
(4, 4, '2024-11-19', 1, 7),
(5, 5, '2024-11-20', 2, 4),
(6, 1, '2024-11-21', 1, 3),
(7, 3, '2024-11-22', 1, 5),
(8, 6, '2024-11-23', 1, 8),
(9, 2, '2024-11-24', 2, 2),
(10, 4, '2024-11-25', 1, 7),
(11, 5, '2024-11-26', 1, 4),
(12, 1, '2024-11-27', 1, 3),
(13, 3, '2024-11-28', 1, 5),
(14, 6, '2024-11-29', 1, 8),
(15, 2, '2024-11-30', 2, 2),
(16, 4, '2024-12-01', 1, 7),
(17, 5, '2024-12-02', 1, 4),
(18, 1, '2024-12-04', 2, 3),
(19, 3, '2024-12-05', 1, 5),
(20, 6, '2024-12-06', 1, 8),
(1, 7, '2024-11-17', 1, 6),
(2, 8, '2024-11-18', 1, 9),
(3, 9, '2024-11-19', 1, 10),
(4, 10, '2024-11-20', 1, 1),
(5, 7, '2024-11-21', 1, 6),
(6, 8, '2024-11-22', 1, 9),
(7, 9, '2024-11-23', 1, 10),
(8, 10, '2024-11-24', 1, 1),
(9, 7, '2024-11-25', 1, 6),
(10, 8, '2024-11-26', 1, 9);

SELECT * FROM GUEST;                -- 10 rows
SELECT * FROM ROOM;                 -- 10 rows
SELECT * FROM EMPLOYEE;             -- 10 rows
SELECT * FROM BOOKING;              -- 20 rows
SELECT * FROM PAYMENT;              -- 20 rows
SELECT * FROM SERVICE;              -- 10 rows
SELECT * FROM SERVICE_BOOKING;      -- 30 rows




/*   
--------------------------------------------------------------------------------------------------------------------
	Team number: 7
	Author: Avinash Reddy Alla, Devendra Reddy Konasani
	Id: 1231965672, 1232253674
	Course: IFT/530
	SQL Server Version: Microsoft SQL Server 2012 (SP1) 
	History
	Date Created    Comments
	12/06/2024      Creating Views
--------------------------------------------------------------------------------------------------------------------
*/

GO
-- Current Occupancy View:
-- This view is useful because it provides an instant snapshot of current hotel occupancy. It shows which rooms are occupied, by whom, and for how long. Hotel staff can quickly check room availability and guest information without complex queries.
CREATE VIEW CurrentOccupancy AS
SELECT r.RoomNumber, r.RoomType, g.FirstName, g.LastName, b.CheckInDate, b.CheckOutDate
FROM ROOM r
JOIN BOOKING b ON r.RoomID = b.RoomID
JOIN GUEST g ON b.GuestID = g.GuestID
WHERE r.Status = 'Occupied' AND GETDATE() BETWEEN b.CheckInDate AND b.CheckOutDate;


go

-- Monthly Revenue Report View:
-- This view is valuable for financial analysis. It provides a monthly breakdown of revenue, total bookings, and average revenue per booking for the past year. Management can use this to track financial performance, identify trends, and make informed decisions about pricing and promotions.
CREATE VIEW MonthlyRevenueReport AS
SELECT 
    DATEADD(MONTH, DATEDIFF(MONTH, 0, p.PaymentDate), 0) AS MonthYear,
    SUM(p.Amount) AS TotalRevenue,
    COUNT(DISTINCT b.BookingID) AS TotalBookings,
    AVG(p.Amount) AS AverageRevenue
FROM PAYMENT p
JOIN BOOKING b ON p.BookingID = b.BookingID
WHERE p.PaymentDate >= DATEADD(MONTH, -12, GETDATE())
GROUP BY DATEADD(MONTH, DATEDIFF(MONTH, 0, p.PaymentDate), 0);



go
-- PopularServices
-- The PopularServices view provides a summary of services booked in the last three months, displaying each service's name, the number of times it was booked (at least three times), and the total revenue generated from those bookings.
CREATE VIEW PopularServices AS
SELECT TOP (100) PERCENT
    s.ServiceName, 
    COUNT(sb.ServiceBookingID) AS TimesBooked,
    SUM(s.Price * sb.Quantity) AS TotalRevenue
FROM SERVICE s 
JOIN SERVICE_BOOKING sb ON s.ServiceID = sb.ServiceID 
JOIN BOOKING b ON sb.BookingID = b.BookingID
WHERE b.CheckOutDate >= DATEADD(MONTH, -3, GETDATE())
GROUP BY s.ServiceName
HAVING COUNT(sb.ServiceBookingID) >= 3;


-- checking if the views are created
go
SELECT * FROM CurrentOccupancy;
SELECT * FROM MonthlyRevenueReport;
SELECT * FROM PopularServices ORDER BY TimesBooked DESC;



/*   
--------------------------------------------------------------------------------------------------------------------
	Team number: 7
	Author: Avinash Reddy Alla, Devendra Reddy Konasani
	Id: 1231965672, 1232253674
	Course: IFT/530
	SQL Server Version: Microsoft SQL Server 2012 (SP1) 
	History
	Date Created    Comments
	12/06/2024      creating an audit table along with the trigger
--------------------------------------------------------------------------------------------------------------------
*/

GO

-- Create the audit table
CREATE TABLE ROOM_AUDIT (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    RoomID INT,
    RoomNumber VARCHAR(10),
    RoomType VARCHAR(50),
    Rate DECIMAL(10,2),
    Status VARCHAR(20),
    AuditAction VARCHAR(10),
    AuditDateTime DATETIME
);

go

-- Create the trigger
CREATE TRIGGER trg_RoomAudit
ON ROOM
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert audit records
    INSERT INTO ROOM_AUDIT (RoomID, RoomNumber, RoomType, Rate, Status, AuditAction, AuditDateTime)
    SELECT i.RoomID, i.RoomNumber, i.RoomType, i.Rate, i.Status, 'INSERT', GETDATE()
    FROM inserted i
    WHERE NOT EXISTS (SELECT 1 FROM deleted);

    INSERT INTO ROOM_AUDIT (RoomID, RoomNumber, RoomType, Rate, Status, AuditAction, AuditDateTime)
    SELECT d.RoomID, d.RoomNumber, d.RoomType, d.Rate, d.Status, 'DELETE', GETDATE()
    FROM deleted d
    WHERE NOT EXISTS (SELECT 1 FROM inserted);

    INSERT INTO ROOM_AUDIT (RoomID, RoomNumber, RoomType, Rate, Status, AuditAction, AuditDateTime)
    SELECT i.RoomID, i.RoomNumber, i.RoomType, i.Rate, i.Status, 'UPDATE', GETDATE()
    FROM inserted i
    INNER JOIN deleted d ON i.RoomID = d.RoomID;
END;


go

-- Test INSERT operation
INSERT INTO ROOM (RoomNumber, RoomType, Rate, Status)
VALUES ('51', 'Suite', 3000.00, 'Available');

-- Test UPDATE operation
UPDATE ROOM
SET Status = 'Occupied'
WHERE RoomNumber = '51';

-- Test DELETE operation
DELETE FROM ROOM
WHERE RoomNumber = '51';

-- View audit results
SELECT * FROM ROOM_AUDIT;



/*   
--------------------------------------------------------------------------------------------------------------------
	Team number: 7
	Author: Avinash Reddy Alla, Devendra Reddy Konasani
	Id: 1231965672, 1232253674
	Course: IFT/530
	SQL Server Version: Microsoft SQL Server 2012 (SP1) 
	History
	Date Created    Comments
	12/06/2024      Creating Stored Procedures and User Defined Functions
--------------------------------------------------------------------------------------------------------------------
*/

GO 

--Stored Procedure
-- This stored procedure retrieves booking information for a specific guest

-- Drop the stored procedure
IF OBJECT_ID('GetGuestBookings', 'P') IS NOT NULL
    DROP PROCEDURE GetGuestBookings;

GO

CREATE PROCEDURE GetGuestBookings
    @GuestID INT
AS
BEGIN
    SELECT b.BookingID, r.RoomNumber, b.CheckInDate, b.CheckOutDate, b.TotalAmount
    FROM BOOKING b
    JOIN ROOM r ON b.RoomID = r.RoomID
    WHERE b.GuestID = @GuestID
    ORDER BY b.CheckInDate DESC
END

GO

-- Execute the stored procedure
EXEC GetGuestBookings @GuestID = 1



GO 

-- User-Defined Function -----------------------------------------------------------------------------------
-- This UDF calculates the total revenue generated by a guest, including both room bookings and additional services

-- Drop the UDF
IF OBJECT_ID('dbo.CalculateGuestRevenue', 'FN') IS NOT NULL
    DROP FUNCTION dbo.CalculateGuestRevenue;

GO

CREATE FUNCTION CalculateGuestRevenue
(
    @GuestID INT
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(10,2)

    SELECT @TotalRevenue = SUM(b.TotalAmount + ISNULL(s.ServiceRevenue, 0))
    FROM BOOKING b
    LEFT JOIN (
        SELECT BookingID, SUM(s.Price * sb.Quantity) AS ServiceRevenue
        FROM SERVICE_BOOKING sb
        JOIN SERVICE s ON sb.ServiceID = s.ServiceID
        GROUP BY BookingID
    ) s ON b.BookingID = s.BookingID
    WHERE b.GuestID = @GuestID

    RETURN ISNULL(@TotalRevenue, 0)
END
GO

-- Use the UDF
SELECT dbo.CalculateGuestRevenue(1) AS TotalRevenue


/* 
-----------------------------------------------------------------------------------------------
	Team number: 7
	Author: Avinash Reddy Alla, Devendra Reddy Konasani
	Id: 1231965672, 1232253674
	Course: IFT/530
	SQL Server Version: Microsoft SQL Server 2012 (SP1) 
	History
	Date Created    Comments
	12/06/2024      Creating a cursor
-----------------------------------------------------------------------------------------------
*/

GO 
CREATE PROCEDURE GenerateEmployeeServiceReport
AS
BEGIN
    SET NOCOUNT ON; -- Prevents the message that shows the number of affected rows

    -- Declare variables to hold employee and service details
    DECLARE @EmpID INT;
    DECLARE @EmpName VARCHAR(100);
    DECLARE @ServiceName VARCHAR(100);
    DECLARE @ServiceCount INT;

    -- Declare the cursor to select employee services and their counts
    DECLARE emp_service_cursor CURSOR FOR 
    SELECT e.EmployeeID, 
           CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName, 
           s.ServiceName, 
           COUNT(sb.ServiceID) AS ServiceCount
    FROM EMPLOYEE e 
    JOIN SERVICE_BOOKING sb ON e.EmployeeID = sb.EmployeeID 
    JOIN SERVICE s ON sb.ServiceID = s.ServiceID 
    GROUP BY e.EmployeeID, e.FirstName, e.LastName, s.ServiceName
    ORDER BY e.EmployeeID; -- Order by Employee ID

    -- Open the cursor
    OPEN emp_service_cursor;

    -- Fetch the first row from the cursor
    FETCH NEXT FROM emp_service_cursor INTO @EmpID, @EmpName, @ServiceName, @ServiceCount;

    -- Loop through the cursor until there are no more rows
    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Print employee service details with count
        PRINT 'Employee ID: ' + CAST(@EmpID AS VARCHAR(10)) + 
              ', Name: ' + @EmpName + 
              ', Service Provided: ' + @ServiceName + 
              ', Times Provided: ' + CAST(@ServiceCount AS VARCHAR(10));

        -- Fetch the next row from the cursor
        FETCH NEXT FROM emp_service_cursor INTO @EmpID, @EmpName, @ServiceName, @ServiceCount;
    END

    -- Close and deallocate the cursor
    CLOSE emp_service_cursor;
    DEALLOCATE emp_service_cursor;
END;
GO

-- Execute the stored procedure to generate the employee service report
EXEC GenerateEmployeeServiceReport;

GO
-- Drop the stored procedure after use
IF OBJECT_ID('GenerateEmployeeServiceReport', 'P') IS NOT NULL
    DROP PROCEDURE GenerateEmployeeServiceReport;
