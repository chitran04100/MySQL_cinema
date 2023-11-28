USE cinema;

#1. Show film which dont have any screening
select name
from film
where name not in (select name
					from film f
                    join screening s on f.id = s.film_id);
                    
#2. Who book more than 1 seat in 1 booking
select first_name, last_name
from (
		select c.first_name, c.last_name, r.booking_id, count(r.seat_id) as booked_seat_total
		from customer c 
		join booking b on c.id = b.customer_id
		join reserved_seat r on b.id = r.booking_id
		group by r.booking_id) as sub_table
where booked_seat_total > 1;

#3. Show room show more than 2 film in one day
select r.name, date(start_time) as show_date, count(distinct film_id) as show_film
from screening s
left join room r on s.room_id = r.id
group by date(start_time), room_id
having show_film > 2;

#4. Which room show the least film?
select r.name, count(distinct film_id) as showing_film
from screening s
left join room r on s.room_id = r.id
group by room_id
having showing_film = (	select min(showing_film) 
						from
							(select r.name, count(distinct film_id) as showing_film
							from screening s
							left join room r on s.room_id = r.id
							group by room_id) as sub_table);

#5. Which film don't have booking
select f.name
from film f
where f.name not in (select distinct f.name
from film f
inner join screening s on f.id = s.film_id
inner join booking b on s.id = b.screening_id);

#6. Which film showed in the most number of room?
select f.name, count(distinct room_id) as room_total
from film f
inner join screening s on f.id = s.film_id
group by film_id
having room_total = (select max(room_total) 
					from (
						select f.name, count(distinct room_id) as room_total
						from film f
						inner join screening s on f.id = s.film_id
						group by film_id) as sub_table
					);

#7. Show number of film that show in every day of week and order descending


#8. show total length of each film that showed in 28/5/2022
select name, length_total
from (
		select name, sum(length_min) as length_total, date(start_time) as show_date
		from film f
		inner join screening s on f.id = s.film_id
		group by name, date(start_time)
		having show_date = "2022-05-28") as sub_table;

#9. Which film has showing time above and below average show time of all film
##ABOVE AVERAGE SHOW TIME
select f.name, avg(s.id) as above_average_showtime
from screening s
inner join film f on s.film_id = f.id
group by f.name
having above_average_showtime > (select avg(s.id)
							from screening s);
                            
##BELOW AVERAGE SHOW TIME
select f.name, avg(s.id) as below_average_showtime
from screening s
inner join film f on s.film_id = f.id
group by f.name
having below_average_showtime < (select avg(s.id)
							from screening s);

#10. Which room have the least number of seat?
select room_id, count(id) as number_of_seat
from seat
group by room_id
having number_of_seat = (select min(number_of_seat)
						from
							(select room_id, count(id) as number_of_seat
							from seat
							group by room_id) as sub_table);

#11. Which room have number of seat bigger than average number of seat of all rooms
select room_id, count(id) as number_of_seat
from seat
group by room_id
having number_of_seat > (select avg(number_of_seat)
						from
							(select room_id, count(id) as number_of_seat
							from seat
							group by room_id) as sub_table);

#12. Ngoai nhung seat mà Ong Dung booking duoc o booking id = 1 thi ong CÓ THỂ (CAN) booking duoc nhung seat nao khac khong?


#13. Show Film with total screening and order by total screening. BUT ONLY SHOW DATA OF FILM WITH TOTAL SCREENING > 10
select s.film_id, count(s.id) as total_screening
from film f
inner join screening s on f.id = s.film_id
group by s.film_id
having total_screening > 10
order by total_screening;

#14. TOP 3 DAY OF WEEK based on total booking
select date(start_time), count(b.id)
from booking b
inner join screening s on b.screening_id = s.id
group by date(start_time)
limit 3;

#15. CALCULATE BOOKING rate over screening of each film ORDER BY RATES.


#16. CONTINUE Q15 -> WHICH film has rate over average?


#17. TOP 2 people who enjoy the least TIME (in minutes) in the cinema based on booking info - only count who has booking info (example : Dũng book film tom&jerry 4 times -> Dũng enjoy 90 mins x 4)
