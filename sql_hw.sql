use sakila;

-- 1a
select last_name, first_name
from actor;

-- 1b
select concat(first_name,' ',last_name) as 'Actor Name'
from actor;

-- 2a
select actor_id, first_name, last_name
from actor
where first_name='joe';

-- 2b 
select first_name, last_name
from actor
where last_name like '%gen%';

-- 2c
select last_name, first_name
from actor
where last_name like '%li%'
order by 1,2;

-- 2d 
select country_id, country
from country
where country in ('Afghanistan','Bangladesh','China');

-- 3a 
alter table actor
add description blob;

-- 3b
alter table actor
drop column description;

-- 4a 
select last_name, count(*)
from actor
group by 1
order by 2 desc;

-- 4b
select last_name, count(*)
from actor
group by 1
having count(*) >=2
order by 2 asc;

-- 4c

-- UPDATE actors
-- SET first_name = 'Harpo'
-- WHERE first_name='groucho';

-- 4d
-- UPDATE actors
-- SET first_name = 'groucho'
-- WHERE first_name='Harpo';

-- 5a
show create table address
-- 6a
select s.last_name, s.first_name, a.address
from staff s
	join address a 
    on a.address_id = s.address_id
group by 1,2,3;

-- 6b
select s.first_name, s.last_name, sum(p.amount)
from staff s
	join payment p
	on p.staff_id = s.staff_id
where p.payment_date like '2005-05%'
group by 1,2
order by 3;

-- 6c
select f.title, sum(fa.actor_id) as actor_count
from film f
	join film_actor fa
    on fa.film_id = f.film_id
group by 1
order by 2;

-- 6d
select count(i.inventory_id)
from film f
	join inventory i
    on i.film_id = f.film_id
where f.title = 'Hunchback Impossible'

-- 6e
select c.last_name, sum(p.amount)
from customer c
	join payment p
    on p.customer_id = c.customer_id
group by c.last_name
order by c.last_name;

-- 7a
select f.title, l.name
from film f
	join language l
    on l.language_id = f.language_id
where f.title like 'K%'or f.title like 'Q%' and l.name='English'
group by 1,2

-- 7b 
select a.first_name, a.last_name
from actor a
where actor_id IN (
	Select actor_id
    from film_actor fa
    where film_id IN(
		Select film_id
        from film f
        where f.title = 'Alone Trip'))
group by 1,2

-- 7c
select c.first_name, c.last_name, c.email
from customer c
	join address a
    on a.address_id = c.address_id
    join city ci
    on ci.city_id = a.city_id
    join country co
    on co.country_id = ci.country_id
where co.country ='Canada'
group by 1,2,3

-- 7d
select f.title
from film f
	join film_category fc
    on fc.film_id = f.film_id
    join category c
    on c.category_id = fc.category_id
where c.name = "Family"
group by 1

-- 7e
select f.title, count(r.rental_id) as times_rented
from film f
	join inventory i
    on i.film_id = f.film_id
    join rental r
    on r.inventory_id = i.inventory_id
group by 1
order by 2 desc

-- 7f
select s.store_id, sum(p.amount)
from store s
	join staff st
    on st.store_id = s.store_id
    join payment p 
    on p.staff_id = st.staff_id
group by 1
order by 2

-- 7g
select s.store_id, c.city, co.country
from store s
    join address a
    on a.address_id = s.address_id
    join city c
    on c.city_id = a.city_id
    join country co
    on co.country_id = c.country_id
group by 1,2,3

-- 7h
select c.name, sum(p.amount) as gross_rev
from category c
	join film_category fc
    on fc.category_id = c.category_id
    join inventory i 
    on i.film_id = fc.film_id
    join rental r
    on r.inventory_id = i.inventory_id
    join payment p
    on p.rental_id = r.rental_id
group by 1
order by 2 desc limit 5

-- 8a
create view Top_5_genres_by_rev as 
	select c.name, sum(p.amount) as gross_rev
	from category c
		join film_category fc
		on fc.category_id = c.category_id
		join inventory i 
		on i.film_id = fc.film_id
		join rental r
		on r.inventory_id = i.inventory_id
		join payment p
		on p.rental_id = r.rental_id
	group by 1
	order by 2 desc limit 5

-- 8b
select * 
from top_5_genres_by_rev

-- 8c
DROP VIEW top_5_genres_by_rev