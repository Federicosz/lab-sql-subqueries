-- Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system.
select title, count(*) as '# of copy' from inventory left join film using (film_id) group by title having title = 'HUNCHBACK IMPOSSIBLE';
Select film_id from film where title = 'HUNCHBACK IMPOSSIBLE';
select title, count(inventory_id) from inventory right join film using (film_id) where (Select inventory_id film where title = 'HUNCHBACK IMPOSSIBLE') group by title ;

-- List all films whose length is longer than the average length of all the films in the Sakila database.
select distinct title, length from film where length> (select avg(length) from film);

-- Use a subquery to display all actors who appear in the film "Alone Trip".
select film_id, concat(first_name,' ', last_name) as actors_name from film_actor left join actor using (actor_id) where film_id=(select film_id from film where title='ALONE TRIP');

-- Sales have been lagging among young families, and you want to target family movies for a promotion. Identify all movies categorized as family films.
select title, rating from film where rating in ('PG','G','PG-13');

-- Retrieve the name and email of customers from Canada using both subqueries and joins. To use joins, you will need to identify the relevant tables and their primary and foreign keys.
select first_name, last_name, email, country from customer
join address using (address_id)
join city using (city_id)
join country using (country_id) where country in (select country from country where country = 'Canada');

/*Determine which films were starred by the most prolific actor in the Sakila database. A prolific actor is defined as the actor who has acted in the most number of films.
 First, you will need to find the most prolific actor and then use that actor_id to find the different films that he or she starred in.*/
 select title, film_id, actor_id from film_actor left join film using (film_id) where actor_id = (select actor_id from film_actor group by actor_id order by count(film_id) desc limit 1) ;
 select actor_id from film_actor group by actor_id order by count(film_id) desc limit 1;
 
/*Find the films rented by the most profitable customer in the Sakila database.
 You can use the customer and payment tables to find the most profitable customer, i.e., the customer who has made the largest sum of payment*/
 select title, inventory_id from rental
 join inventory using (inventory_id)
 join film using (film_id)
 where customer_id= (select customer_id from payment group by customer_id order by sum(amount) desc limit 1);
 
/*Retrieve the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
 You can use subqueries to accomplish this.*/
 select count(*) as 'number of customer' from customer;
 select (select sum(amount) from payment)/(select count(*) as 'number of customer' from customer) as 'avg_spend';
 select customer_id, sum(amount) from payment group by customer_id having sum(amount)> (select (select sum(amount) from payment)/(select count(*) as 'number of customer' from customer) as 'avg_spend');
 