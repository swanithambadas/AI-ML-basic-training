use sakila;

show full tables;

-- 1. display all customer details who have made more than 5 payments.
select * from customer;
select * from payment;
select c.first_name, c.last_name, c.email, count(p.payment_id) as total_payments
from customer c 
join payment p on c.customer_id = p.customer_id
group by c.customer_id, c.first_name, c.last_name, c.email
having count(payment_id) > 5;

-- 2. Find the names of actors who have acted in more than 10 films.
select * from actor;
select * from film;
select * from film_actor;
select a.first_name, a.last_name, count(fa.film_id) as total_films
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by a.first_name, a.last_name, a.actor_id
having count(fa.film_id) > 10;

-- 3. Find the names of customers who never made a payment.
select c.first_name, c.last_name
from customer c
left join payment p on c.customer_id = p.customer_id
where payment_id is null;

-- 4. List all films whose rental rate is higher than the average rental rate of all films.
select * from film;
select title, rental_rate
from film 
where rental_rate > (
select avg(rental_rate)
from film)
order by rental_rate desc;

-- 5. List the titles of films that were never rented.
select * from film;
select * from inventory;
select * from rental;
select f.title
from film f
left join inventory i on i.film_id = f.film_id
left join rental r on r.inventory_id = i.inventory_id
where r.rental_id is null;

-- 6. Display the customers who rented films in the same month as customer with ID 5.
select * from customer;
select * from rental;

select c.first_name, c.last_name
from customer c
join rental r on c.customer_id = r.customer_id
where date_format(r.rental_date,'%Y-%m') in(
	select distinct date_format(rental_date, '%Y-%m')
    from rental
    where customer_id = 5);
    

-- 7. Find all staff members who handled a payment greater than the average payment amount.
select * from payment;
select * from staff;

select distinct s.first_name, s.last_name
from staff s
join payment p on s.staff_id = p.staff_id
where p.amount > (
	select avg(amount) 
    from payment);
    
-- 8. Show the title and rental duration of films whose rental duration is greater than the average.
select * from film;

select title, rental_duration 
from film 
where rental_duration > (
	select avg(rental_duration)
    from film);

-- 9. Find all customers who have the same address as customer with ID 1.
select * from customer;   
select * from address;
select first_name, last_name
from customer 
where address_id = (
	select address_id 
    from customer 
    where customer_id = 1);

-- 10. List all payments that are greater than the average of all payments.
select * from payment;
select * 
from payment
where amount >(
	select avg(amount)
    from payment);



