-- Project: Airline Reservation System
-- Author: Nandini Samdariya
-- Objective:
-- Design a relational database schema for managing airline flights, customers,
-- seat bookings, and payment status, including booking and cancellation handling.

-- 1. Select the database to use
USE airline_reservation_system;

-- 2. TABLE CREATION
-- Flights: Stores flight info including schedule and pricing
-- Customers: Stores customer personal info with contact and passport details
-- Seats: Stores seat details for each flight and booking status
-- Bookings: Stores booking info linking customers, flights, seats, status, and payments

CREATE TABLE Flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(10) UNIQUE NOT NULL,
    source VARCHAR(50),
    destination VARCHAR(50),
    departure_time DATETIME,
    arrival_time DATETIME
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);

CREATE TABLE Seats (
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_id INT,
    seat_number VARCHAR(5),
    is_booked BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    flight_id INT,
    seat_id INT,
    booking_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('Confirmed', 'Cancelled') DEFAULT 'Confirmed',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (flight_id) REFERENCES Flights(flight_id),
    FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
);

-- 3. SAMPLE DATA INSERTION
-- Insert sample flights
-- Insert sample customers
-- Insert sample seats
-- Insert sample bookings

INSERT INTO Flights (flight_number, source, destination, departure_time, arrival_time)
VALUES 
('AI101', 'Kolkata', 'Rajasthan', '2025-08-09 08:00:00', '2025-08-12 10:00:00'),
('AI303', 'Delhi', 'Chennai', '2025-07-22 06:30:00', '2025-07-22 09:15:00');

INSERT INTO Customers (full_name, email, phone_number)
VALUES 
('Nandini Samdariya', 'nandini.samdariya10@email.com', '8240147872'),
('Priya Kapoor', 'priya@email.com', '9876523456');

INSERT INTO Seats (flight_id, seat_number) 
VALUES 
(1, '1A'), (1, '1B'), (1, '2A'), (1, '2B'),
(2, '1A'), (2, '1B'), (2, '2A'), (2, '2B');

INSERT INTO Bookings (customer_id, flight_id, seat_id)
VALUES 
(1, 1, 1),
(2, 2, 3);

-- 4. TRIGGERS: Maintain seat booking status
-- Automatically mark seat as booked after a booking is made
-- Automatically free seat when booking is cancelled

DELIMITER //
CREATE TRIGGER trg_mark_seat_booked
AFTER INSERT ON Bookings
FOR EACH ROW
BEGIN
    UPDATE Seats
    SET is_booked = TRUE
    WHERE seat_id = NEW.seat_id;
END;
//
CREATE TRIGGER trg_free_seat_on_cancel
AFTER UPDATE ON Bookings
FOR EACH ROW
BEGIN
    IF NEW.status = 'Cancelled' THEN
        UPDATE Seats
        SET is_booked = FALSE
        WHERE seat_id = NEW.seat_id;
    END IF;
END;
//
DELIMITER ;

-- 5. USEFUL QUERIES
-- Check available seats on a specific flight
-- Search for flights by source and destination
-- Get booking details for a particular customer

SELECT seat_number FROM Seats 
WHERE flight_id = 1 AND is_booked = FALSE;

SELECT * FROM Flights
WHERE source = 'Kolkata' AND destination = 'Rajasthan';

SELECT 
    b.booking_id, 
    c.full_name, 
    f.flight_number, 
    s.seat_number, 
    b.status
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Seats s ON b.seat_id = s.seat_id
WHERE c.customer_id = 1;


-- 6. VIEWS for simplified reporting
-- BookingSummary: Detailed view combining bookings, customers, flights, seats
-- AvailableFlights: List flights with count of unbooked seats

CREATE VIEW BookingSummary AS
SELECT 
    b.booking_id, 
    c.full_name,
    c.email,
    f.flight_number,
    f.source,
    f.destination,
    s.seat_number,
    b.status,
    b.booking_date
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Seats s ON b.seat_id = s.seat_id;


CREATE VIEW AvailableFlights AS
SELECT 
    f.flight_id,
    f.flight_number,
    f.source,
    f.destination,
    COUNT(s.seat_id) AS available_seats
FROM Flights f
JOIN Seats s ON f.flight_id = s.flight_id
WHERE s.is_booked = FALSE
GROUP BY f.flight_id;

-- 7. BOOKING STATUS & SEAT AVAILABILITY TEST
-- Update booking status to simulate cancellation
-- Check if seat is freed after cancellation via trigger

UPDATE Bookings 
SET status = 'Cancelled' 
WHERE booking_id = 2;

SELECT * FROM Seats WHERE seat_id = 3;

-- 8. TABLE MODIFICATIONS (ALTER TABLE)
-- Add gender and passport_no to Customers for extended identity management
-- Add price to Flights for fare tracking
-- Add payment_status to Bookings to monitor transaction state

ALTER TABLE Customers 
ADD COLUMN gender ENUM('Male', 'Female', 'Other') AFTER full_name;

ALTER TABLE Customers 
ADD COLUMN passport_no VARCHAR(20) UNIQUE AFTER phone_number;

ALTER TABLE Flights 
ADD COLUMN price DECIMAL(10,2) DEFAULT 0.00 AFTER arrival_time;

ALTER TABLE Bookings 
ADD COLUMN payment_status ENUM('Paid', 'Pending', 'Failed') DEFAULT 'Pending' AFTER status;

DESCRIBE Customers;
DESCRIBE Flights;
DESCRIBE Bookings;


-- 9. DATA UPDATES
-- Update gender and passport number for sample customers
-- Set pricing for sample flights
-- Set payment status for existing bookings

UPDATE Customers 
SET gender = 'Female', passport_no = 'P00101002'
WHERE customer_id = 1;

UPDATE Customers 
SET gender = 'Female', passport_no = 'P0044556'
WHERE customer_id = 2;

UPDATE Flights 
SET price = 9500.00
WHERE flight_id = 1;

UPDATE Flights 
SET price = 5700.00
WHERE flight_id = 2;

UPDATE Bookings 
SET payment_status = 'Paid'
WHERE booking_id = 1;

UPDATE Bookings 
SET payment_status = 'Pending'
WHERE booking_id = 2;

-- 10. VIEW RECREATION
-- Drop and recreate BookingSummary view to include new columns added after schema update

DROP VIEW IF EXISTS BookingSummary;

CREATE VIEW BookingSummary AS
SELECT 
    b.booking_id, 
    c.full_name,
    c.email,
    c.gender,
    c.passport_no,
    f.flight_number,
    f.source,
    f.destination,
    f.price,
    s.seat_number,
    b.status,
    b.payment_status,
    b.booking_date
FROM Bookings b
JOIN Customers c ON b.customer_id = c.customer_id
JOIN Flights f ON b.flight_id = f.flight_id
JOIN Seats s ON b.seat_id = s.seat_id;

-- 11. FINAL OUTPUTS
-- View final content of all major tables and views for verification

SELECT * FROM Customers;
SELECT * FROM Flights;
SELECT * FROM Seats;
SELECT * FROM Bookings;
SELECT * FROM BookingSummary;
SELECT * FROM AvailableFlights;








