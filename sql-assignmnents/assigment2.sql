-- 1. Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
-- create a unique identifier using a combination of other columns and group them 
Select first_name, last_name, email, count(*) as total
from customer 
group by first_name, last_name, email
having count(*) > 1;


-- 2. Number of times letter 'a' is repeated in film descriptions
-- we can use a method called length subtraction calculate the length of total description and the subtract the number of a 
select sum(length(description) - length(replace(description, 'a', ''))) as total_a
from film;
-- 3. Number of times each vowel is repeated in film descriptions 
select 
sum(length(description) - length(replace(description, 'a', ''))) as total_a,
sum(length(description) - length(replace(description, 'e', ''))) as total_e,
sum(length(description) - length(replace(description, 'i', ''))) as total_i,
sum(length(description) - length(replace(description, 'o', ''))) as total_o,
sum(length(description) - length(replace(description, 'u', ''))) as total_u
from film;
-- 4. Display the payments made by each customer
        -- 1. Month wise
        select customer_id, month(payment_date) as payment_month, sum(amount) as total_amount
        from payment
        group by customer_id, month(payment_date);
        -- 2. Year wise
        select customer_id, year(payment_date) as payment_year, sum(amount) as total_amount
        from payment
        group by customer_id, year(payment_date);
        -- 3. Week wise
		select customer_id, week(payment_date) as payment_week, sum(amount) as total_amount
        from payment
        group by customer_id, week(payment_date);

-- 5. Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date
Select 
2024 as target_year,
case 
when (2024%4 = 0 and 2024%100 != 0 ) or (2024%400 = 0) then "leap year"
Else 'Regular year'
end as leap_year_status;


-- 6. Display number of days remaining in the current year from today.
-- we can find the year first using YEAR concat with current date and the find date difference.
Select datediff(str_to_date(concat(year(curdate()), '-12-31'), '%Y-%m-%d'), curdate()) as days_remaining_this_year;
-- 7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.
select payment_id, payment_date ,concat('Q', quarter(payment_date)) as Quarter
from payment;
