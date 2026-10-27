-- Queries, updates, deletes and view | Hotel Room Booking System
USE hotel_booking_db;

-- Query 1: Rooms currently available
SELECT r.room_no, t.type_name, t.price_per_night, r.floor_no
FROM rooms r
JOIN room_types t ON r.type_id = t.type_id
WHERE r.status = 'Available'
ORDER BY r.room_no;

-- Query 2: Complete booking details
SELECT b.booking_id, g.guest_name, b.room_no, b.check_in,
       b.check_out, b.total_amount, b.status
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
ORDER BY b.booking_id;

-- Query 3: Revenue by room type
SELECT t.type_name, COUNT(b.booking_id) AS total_bookings,
       SUM(b.total_amount) AS total_revenue
FROM bookings b
JOIN rooms r ON b.room_no = r.room_no
JOIN room_types t ON r.type_id = t.type_id
WHERE b.status <> 'Cancelled'
GROUP BY t.type_name
ORDER BY total_revenue DESC;

-- Query 4: Repeat guests
SELECT g.guest_name, COUNT(*) AS visits, SUM(b.total_amount) AS total_spent
FROM guests g
JOIN bookings b ON g.guest_id = b.guest_id
GROUP BY g.guest_id, g.guest_name
HAVING COUNT(*) > 1;

-- Query 5: Guests who booked a Deluxe room
SELECT guest_name, city
FROM guests
WHERE guest_id IN (SELECT b.guest_id
                   FROM bookings b
                   JOIN rooms r ON b.room_no = r.room_no
                   WHERE r.type_id = 2)
ORDER BY guest_name;

-- Query 6: Pending payments
SELECT b.booking_id, g.guest_name, b.total_amount,
       IFNULL(SUM(p.amount), 0) AS paid,
       b.total_amount - IFNULL(SUM(p.amount), 0) AS balance
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
LEFT JOIN payments p ON b.booking_id = p.booking_id
WHERE b.status <> 'Cancelled'
GROUP BY b.booking_id, g.guest_name, b.total_amount
HAVING balance > 0
ORDER BY balance DESC;

-- Query 7: Collection by payment mode
SELECT pay_mode, COUNT(*) AS transactions, SUM(amount) AS total_collected
FROM payments
GROUP BY pay_mode
ORDER BY total_collected DESC;

-- Query 8: Total revenue collected
SELECT SUM(amount) AS total_revenue FROM payments;

-- Query 9: Guests who have never booked
SELECT g.guest_id, g.guest_name, g.city
FROM guests g
LEFT JOIN bookings b ON g.guest_id = b.guest_id
WHERE b.booking_id IS NULL;

-- Check-out and final payment (UPDATE and INSERT)
UPDATE bookings SET status = 'Checked-Out' WHERE booking_id = 8;
UPDATE rooms SET status = 'Available' WHERE room_no = 302;
INSERT INTO payments VALUES (11, 8, 4500, '2026-10-28', 'UPI');
SELECT b.booking_id, b.status AS booking_status, r.room_no, r.status AS room_status
FROM bookings b
JOIN rooms r ON b.room_no = r.room_no
WHERE b.booking_id = 8;

-- Cancelling a booking (UPDATE)
UPDATE bookings SET status = 'Cancelled' WHERE booking_id = 10;
SELECT booking_id, guest_id, room_no, status FROM bookings WHERE status = 'Cancelled';

-- Deleting an unused guest record (DELETE)
DELETE FROM guests WHERE guest_id = 9;
SELECT COUNT(*) AS total_guests FROM guests;

-- Creating and using a view
CREATE VIEW booking_summary AS
SELECT b.booking_id, g.guest_name, r.room_no, t.type_name,
       b.nights, b.total_amount, b.status
FROM bookings b
JOIN guests g ON b.guest_id = g.guest_id
JOIN rooms r ON b.room_no = r.room_no
JOIN room_types t ON r.type_id = t.type_id;
SELECT * FROM booking_summary WHERE status IN ('Checked-In', 'Confirmed') ORDER BY booking_id;
