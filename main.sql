use sakila;

# 1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?

SELECT COUNT(inventory.film_id) as copies_count from INVENTORY
	JOIN film
		ON inventory.film_id = film.film_id
	WHERE film.title = "Hunchback Impossible";

# 2. List all films whose length is longer than the average of all the films.

SELECT title from FILM 
WHERE length >
	(SELECT AVG(length)
    FROM FILM);
 
# 3. Use subqueries to display all actors who appear in the film _Alone Trip_.

SELECT first_name, last_name from actor
WHERE actor_id in
	(SELECT actor_id from film_actor
		WHERE film_id = 
        (SELECT film_id from film
			WHERE title = "Alone Trip"));

# 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies 
# categorized as family films.

SELECT title FROM film
	WHERE film_id in
		(SELECT film_id from film_category
			WHERE category_id in 
			(SELECT category_id from category
				WHERE name = "family"));

# 5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create 
# a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you 
# get the relevant information.
use sakila;
SELECT first_name, last_name, email FROM customer
	WHERE address_id in
		(SELECT address_id from address
			WHERE city_id in
            (SELECT city_id from city
				WHERE country_id in
                (SELECT country_id from country
                WHERE country = "Canada")));
                
SELECT customer.first_name, customer.last_name, customer.email FROM customer
	JOIN address
		ON customer.address_id = address.address_id
	JOIN city
		ON address.city_id = city.city_id
	JOIN country
		ON city.country_id = country.country_id
	WHERE country.country = "Canada";

# 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted
# in the most number of films. First you will have to find the most prolific actor and then use that actor_id to 
# find the different films that he/she starred.

SELECT title FROM film
WHERE film_id in
    (SELECT film_id from film_actor
    WHERE actor_id =
        (SELECT actor_id FROM film_actor
        WHERE film_id IN
            (SELECT COUNT(film_id) FROM film
            ORDER BY COUNT(film_id) DESC)
            LIMIT 1));
			
# 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most 
# profitable customer ie the customer that has made the largest sum of payments

SELECT title from film
WHERE film_id in
	(SELECT film_id from inventory
		WHERE inventory_id in
        (SELECT inventory_id from rental
			WHERE customer_id =
            (SELECT customer_id FROM payment
                GROUP BY customer_id
                ORDER BY SUM(amount) DESC
                LIMIT 1)));
                    

# 8. Get the `client_id` and the `total_amount_spent` of those clients who spent more than the average of the 
# `total_amount` spent by each client.


SELECT customer_id, SUM(amount) AS total_per_client FROM payment
GROUP BY customer_id
HAVING total_per_client >
(SELECT AVG(total_per_client) FROM 
                    (SELECT customer_id, SUM(amount) AS total_per_client FROM payment
                    GROUP BY customer_id) AS table_total_per_client);