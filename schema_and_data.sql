-- Hotel Room Booking System | DBMS Mini Project
-- Author: Randeep Singh (UID 25BCD10148)

CREATE DATABASE hotel_booking_db;
USE hotel_booking_db;

CREATE TABLE guests (
    guest_id INT PRIMARY KEY,
    guest_name VARCHAR(50) NOT NULL,
    phone VARCHAR(10) NOT NULL,
    email VARCHAR(60),
    city VARCHAR(30)
);

CREATE TABLE room_types (
    type_id INT PRIMARY KEY,
    type_name VARCHAR(30) NOT NULL,
    price_per_night INT NOT NULL,
    max_guests INT NOT NULL
);

CREATE TABLE rooms (
    room_no INT PRIMARY KEY,
    type_id INT NOT NULL,
    floor_no INT NOT NULL,
    status VARCHAR(15) NOT NULL DEFAULT 'Available',
    FOREIGN KEY (type_id) REFERENCES room_types(type_id)
);

CREATE TABLE bookings (
    booking_id INT PRIMARY KEY,
    guest_id INT NOT NULL,
    room_no INT NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    nights INT NOT NULL,
    total_amount INT NOT NULL,
    status VARCHAR(15) NOT NULL DEFAULT 'Confirmed',
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (room_no) REFERENCES rooms(room_no)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    booking_id INT NOT NULL,
    amount INT NOT NULL,
    pay_date DATE NOT NULL,
    pay_mode VARCHAR(10) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);

INSERT INTO guests VALUES
    (1, 'Aman Verma', '9876501234', 'aman.verma@example.com', 'Ludhiana'),
    (2, 'Simran Kaur', '9815012345', 'simran.kaur@example.com', 'Amritsar'),
    (3, 'Rohit Sharma', '9988776655', 'rohit.sharma@example.com', 'Delhi'),
    (4, 'Priya Singh', '9417045678', 'priya.singh@example.com', 'Patiala'),
    (5, 'Gurpreet Singh', '9780123456', 'gurpreet.s@example.com', 'Jalandhar'),
    (6, 'Neha Gupta', '9872098765', 'neha.gupta@example.com', 'Chandigarh'),
    (7, 'Karan Malhotra', '9646012345', 'karan.m@example.com', 'Jaipur'),
    (8, 'Anjali Mehta', '9501234567', 'anjali.mehta@example.com', 'Shimla'),
    (9, 'Harleen Kaur', '9915566778', 'harleen.k@example.com', 'Mohali');

INSERT INTO room_types VALUES
    (1, 'Standard', 1800, 2),
    (2, 'Deluxe', 2800, 3),
    (3, 'Executive Suite', 4500, 4),
    (4, 'Family Suite', 6000, 6);

INSERT INTO rooms VALUES
    (101, 1, 1, 'Available'),
    (102, 1, 1, 'Available'),
    (103, 1, 1, 'Available'),
    (201, 2, 2, 'Available'),
    (202, 2, 2, 'Available'),
    (203, 2, 2, 'Occupied'),
    (301, 3, 3, 'Available'),
    (302, 3, 3, 'Occupied'),
    (401, 4, 4, 'Available'),
    (402, 4, 4, 'Available');

INSERT INTO bookings VALUES
    (1, 1, 201, '2026-09-05', '2026-09-08', 3, 8400, 'Checked-Out'),
    (2, 2, 101, '2026-09-12', '2026-09-14', 2, 3600, 'Checked-Out'),
    (3, 3, 301, '2026-09-20', '2026-09-23', 3, 13500, 'Checked-Out'),
    (4, 4, 202, '2026-10-02', '2026-10-05', 3, 8400, 'Checked-Out'),
    (5, 1, 401, '2026-10-10', '2026-10-13', 3, 18000, 'Checked-Out'),
    (6, 5, 102, '2026-10-18', '2026-10-20', 2, 3600, 'Checked-Out'),
    (7, 6, 203, '2026-10-25', '2026-10-29', 4, 11200, 'Checked-In'),
    (8, 7, 302, '2026-10-26', '2026-10-28', 2, 9000, 'Checked-In'),
    (9, 3, 103, '2026-11-02', '2026-11-04', 2, 3600, 'Confirmed'),
    (10, 8, 201, '2026-11-10', '2026-11-12', 2, 5600, 'Confirmed');

INSERT INTO payments VALUES
    (1, 1, 8400, '2026-09-08', 'UPI'),
    (2, 2, 3600, '2026-09-14', 'Cash'),
    (3, 3, 13500, '2026-09-23', 'Card'),
    (4, 4, 8400, '2026-10-05', 'Card'),
    (5, 5, 10000, '2026-10-10', 'UPI'),
    (6, 5, 8000, '2026-10-13', 'Cash'),
    (7, 6, 3600, '2026-10-20', 'UPI'),
    (8, 7, 5000, '2026-10-25', 'Card'),
    (9, 8, 4500, '2026-10-26', 'UPI'),
    (10, 9, 1000, '2026-10-20', 'UPI');
