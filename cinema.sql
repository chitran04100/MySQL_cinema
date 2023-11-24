USE cinema;

-- Q1. Show film name ONLY which has screening.
SELECT DISTINCT name 
FROM film
INNER JOIN screening ON film.id = screening.film_id;

-- Q2. Show Room name with all seat row and seat column of "Room 2"
SELECT seat.row, seat.number
FROM room
INNER JOIN seat ON room.id = seat.room_id
WHERE room.id = 2;

-- Q3. Show all Screening Infomation including film name, room name, time of film "Tom&Jerry"
SELECT film.name, room.name, screening.start_time
FROM screening
RIGHT JOIN film ON screening.film_id = film.id
RIGHT JOIN room ON screening.room_id = room.id
WHERE film.id = 1;

-- Q4. Show what seat that customer "Dung Nguyen" booked
SELECT seat.row, seat.number
FROM booking
INNER JOIN customer ON booking.customer_id = customer.id
INNER JOIN reserved_seat ON booking.id = reserved_seat.booking_id
INNER JOIN seat ON reserved_seat.seat_id = seat.id
WHERE customer.id = 1;

-- Q5. How many film that showed in 24/5/2022
SELECT COUNT(film_id) AS number_of_film
FROM screening
WHERE DATE(start_time) = "2022-05-24";

-- Q6. What is the maximum length and minumum length of all film
SELECT MAX(length_min) AS maximum_length, MIN(length_min) AS minimum_length
FROM film;

-- Q7. How many seat of Room 7
SELECT COUNT(*) AS number_of_seat
FROM seat
INNER JOIN room ON seat.room_id = room.id
WHERE room.id = 7;

-- Q8. Total seat are booked of film "Tom&Jerry"
SELECT COUNT(reserved_seat.seat_id) AS total_seat
FROM booking 
INNER JOIN screening ON booking.screening_id = screening.id
INNER JOIN film ON screening.film_id = film.id
INNER JOIN reserved_seat ON booking.id = reserved_seat.booking_id
WHERE film.id = 1;
