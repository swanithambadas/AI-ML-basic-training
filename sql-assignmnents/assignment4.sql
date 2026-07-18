use sakila;

show full tables;

-- 1. List all customers along with the films they have rented.
select * from customer;
select * from film;
select * from rental;
select * from inventory;

select c.first_name, c.last_name, f.title
from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id;


-- 2. List all customers and show their rental count, including those who haven't rented any films.
select * from customer;
select * from rental;

select c.customer_id, c.first_name, c.last_name, count(rental_id)
from customer c
left join rental r on c.customer_id = r.customer_id
group by c.first_name, c.last_name, c.customer_id;

-- 3. Show all films along with their category. Include films that don't have a category assigned.

select * from film;
select * from category;
select * from film_category;

select f.title, c.name
from film f
left join film_category fc on f.film_id = fc.film_id
left join category c on fc.category_id = c.category_id;


-- 4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).
select * from customer;
select * from staff;

select c.email as customer_email , s.email as staff_email
from customer c
left join staff s on c.store_id = s.store_id

union 

select c.email as customer_email , s.email as staff_email
from customer c
right join staff s on c.store_id = s.store_id;
 

-- 5. Find all actors who acted in the film "ACADEMY DINOSAUR".

select * from actor;
select * from film;
select * from film_actor;

select a.first_name, a.last_name, f.title
from actor a
join film_actor fa on a.actor_id = fa.actor_id
join film f on fa.film_id = f.film_id
where f.title = 'ACADEMY DINOSAUR';



-- 6. List all stores and the total number of staff members working in each store, even if a store has no staff.
select * from store;
select * from staff;
select * from staff_list;

select so.store_id ,  count(st.staff_id) 
from store so
left join staff st on so.store_id = st.store_id
group by so.store_id;



-- 7. List the customers who have rented films more than 5 times. Include their name and total rental count.
select c.customer_id, c.first_name, c.last_name, count(rental_id)
from customer c
left join rental r on c.customer_id = r.customer_id
group by c.first_name, c.last_name, c.customer_id
having count(rental_id) > 5;