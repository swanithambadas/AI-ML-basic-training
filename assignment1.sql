use sakila;
show full tables;

-- 1. Get all customers whose first name starts with 'J' and who are active.
SELECT * 
FROM CUSTOMER WHERE first_name LIKE 'J%' 
AND active = 1;

-- 2. Find all films where the title contains the word 'ACTION' or the description contains 'WAR'.

SELECT * 
FROM FILM WHERE title LIKE '%ACTION%' OR description LIKE '%WAR%'; -- why is it returning a null title 

-- 3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
SELECT * 
FROM CUSTOMER WHERE first_name LIKE '%a' AND last_name != 'SMITH'; 

-- 4. Get all films where the rental rate is greater than 3.0 and the replacement cost is not null.
SELECT *
FROM FILM WHERE rental_rate > 3.0 AND replacement_cost is not null; 

-- 5. Count how many customers exist in each store who have active status = 1.
SELECT store_id, count(customer_id) as active_customers
from customer 
where active = 1
group by store_id;

-- 6. Show distinct film ratings available in the film table.
Select distinct(rating) 
from film;

-- 7. Find the number of films for each rental duration where the average length is more than 100 minutes.
Select rental_duration, count(film_id) as total_films
from film
group by rental_duration
having avg(length)> 100;

-- 8. List payment dates and total amount paid per date, but only include days where more than 100 payments were made.
select payment_date, SUM(amount) as Total_amount_paid_per_day
from payment
group by payment_date
having count(payment_id) > 100;

-- 9. Find customers whose email address is null or ends with '.org'.
select * 
from customer 
where email is null or email like '%.org';

-- 10. List all films with rating 'PG' or 'G', and order them by rental rate in descending order.
Select * 
from film 
where rating in ('PG', 'G') -- or we can write rating = "PG" or rating = "G"
order by rental_rate desc;


-- 11. Count how many films exist for each length where the film title starts with 'T' and the count is more than 5.
select length, count(film_id) as count 
from film
where title like 'T%'
group by length
having count(film_id) > 5;

-- 12. List all actors who have appeared in more than 10 films.
select a.first_name, a.last_name, count(fa.film_id) as total_films
from actor a 
join film_actor fa on a.actor_id = fa.actor_id
group by a.actor_id
having count(fa.film_id) > 10;


-- 13. Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second.
Select * 
from film 
order by rental_rate desc, length desc
limit 5;

-- 14. Show all customers along with the total number of rentals they have made, ordered from most to least rentals.
select c.first_name, c.last_name, count(r.rental_id) as total_rentals
from customer c
join rental r on c.customer_id = r.customer_id
group by c.customer_id
order by count(r.rental_id) desc;

-- 15. List the film titles that have never been rented.
select title
from film 
where film_id not in (
select i.film_id
from inventory i 
join rental r on r.inventory_id = i.inventory_id) ;



