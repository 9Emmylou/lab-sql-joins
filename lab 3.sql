# List the number of films per category.
select c.name, count(*)
from category c
inner join film_category fc
on c.category_id = fc.category_id
group by c.name;

# Retrieve the store ID, city, and country for each store
select s.store_id, city, country
from store s
join address a
on a.address_id = s.address_id
join city c
on c.city_id = a.address_id
join country co 
on co.country_id = c.country_id;

# Calculate the total revenue generated by each store in dollars
select s.store_id, sum(amount)
from payment p
join staff s
on p.staff_id = s.staff_id
group by s.store_id;

# Determine the average running time of films for each category.
select c.name, avg(length)
from category c
join film_category ca
on c.category_id = ca.category_id
join film f
# on f.film_id = ca.film_id or
using (film_id)
group by c.name;

# Identify the film categories with the longest average running time
select c.name, avg(length)
from category c
join film_category ca
on c.category_id = ca.category_id
join film f
# on f.film_id = ca.film_id or
using (film_id)
group by c.name
order by avg(length) desc
limit 1;

# Display the top 10 most frequently rented movies in descending order
select f.title, count(*)
from film f
join inventory
using (film_id)
join rental
using (inventory_id)
group by f.title
order by count(*) desc
limit 10;

#Determine if "Academy Dinosaur" can be rented from Store 1.
select f.title, store_id
from film f
join inventory
using (film_id)
where title = 'ACADEMY DINOSAUR';

#Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' 
#Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
select f.title,  case when inventory.film_id is null then "NOT available" else "Available" end as Availability
from film f
left join inventory
using (film_id)
group by 1, 2;