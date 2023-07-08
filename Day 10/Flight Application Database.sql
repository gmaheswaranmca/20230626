/*					Database Name is "FlightSystemDb"  */

/* Admin: AdminId, Username, Password */

CREATE TABLE Admin (		
	AdminId int not null identity(1,1), 
	Username varchar(50) not null, 
	Password varchar(50) not null,
	CONSTRAINT pk_Admin_AdminId PRIMARY KEY(AdminId)
);

INSERT INTO Admin(Username, Password)
VALUES('shashank','1234'),
('priya','1234'),
('boomi','1234');
	
/*		Flight: FlightId, FlightNumber, AirlineName, Source, Destination, 
						TravelDate, NumberOfSeats, TicketFare */

CREATE TABLE Flight (		
	FlightId int not null identity(1,1), 
	FlightNumber varchar(50) not null, 
	AirlineName varchar(255) not null,
	Source varchar(255) not null,
	Destination varchar(255) not null,
	TravelDate DATETIME not null,
	NumberOfSeats int not null,
	TicketFare FLOAT not null,
	CONSTRAINT pk_Flight_FlightId PRIMARY KEY(FlightId)
);
						
/*		Customer: CustomerId, Name, MobileNumber, Username, Password */
CREATE TABLE Customer (		
	CustomerId int not null identity(1,1), 
	Name varchar(255) not null,
	MobileNumber varchar(20) not null,
	Username varchar(50) not null, 
	Password varchar(50) not null,
	CONSTRAINT pk_Customer_CustomerId PRIMARY KEY(CustomerId)
);


/*		Booking: BookingId, CustomerId, FlightId,
				BookingNumber, BookingDate, TravelDate, NumberOfPassengers, BillAmount */
CREATE TABLE Booking (		
	BookingId int not null identity(1,1), 
	CustomerId int not null,
	FlightId int not null,
	BookingNumber varchar(20) not null,
	BookingDate DATETIME not null,
	TravelDate DATETIME not null,
	NumberOfPassengers int not null,
	BillAmount float not null,
	CONSTRAINT pk_Booking_BookingId PRIMARY KEY(BookingId),
	CONSTRAINT fk_Booking_Customer_CustomerId FOREIGN KEY(CustomerId) REFERENCES Customer(CustomerId),
	CONSTRAINT fk_Booking_Flight_FlightId FOREIGN KEY(FlightId) REFERENCES Flight(FlightId)
);				
/*		BookingPassenger: BookingId, SerialNumber, TicketNumber, PassengerName, 
					Age, IdCardDetails */
CREATE TABLE BookingPassenger (		
	BookingId int not null, 
	SerialNumber int not null, 
	TicketNumber VARCHAR(50) not null, 
	PassengerName VARCHAR(255) not null, 
	Age int not null, 
	IdCardDetails VARCHAR(512) not null, 
	CONSTRAINT pk_BookingPassenger_BookingId_SerialNumber PRIMARY KEY(BookingId, SerialNumber),
	CONSTRAINT fk_BookingPassenger_Booking_BookingId FOREIGN KEY(BookingId) REFERENCES Booking(BookingId)
);				

SELECT * FROM Admin;
SELECT * FROM Flight;
SELECT * FROM Customer;
SELECT * FROM Booking;
SELECT * FROM BookingPassenger;

					
-- DROP TABLE Admin;
-- DROP TABLE Flight;
-- DROP TABLE Customer;
-- DROP TABLE Booking;
-- DROP TABLE BookingPassenger;
					
-- sp_help Admin;
-- sp_help Flight;
-- sp_help Customer;
-- sp_help Booking;
-- sp_help BookingPassenger;