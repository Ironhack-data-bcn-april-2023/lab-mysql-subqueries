USE sakila;

-- 1.How many copies of the film _Hunchback Impossible_ exist in the inventory system?

SELECT COUNT(*) AS Copies FROM inventory i
JOIN film f ON i.film_id = f.film_id
WHERE f.title = 'Hunchback Impossible';

-- 2.List all films whose length is longer than the average of all the films.

SELECT title FROM Film 
WHERE length > (SELECT AVG(length) FROM Film);

-- 3.Use subqueries to display all actors who appear in the film _Alone Trip_.

SELECT actor.first_name, actor.last_name FROM actor
	WHERE actor.actor_id IN 
    (SELECT film_actor.actor_id
		FROM film_actor
		WHERE film_actor.film_id = 
			(SELECT film.film_id FROM film 
            WHERE film.title = "Alone Trip"));

-- 4.Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.

SELECT film.title FROM film
	WHERE film.film_id in
    (SELECT film_category.film_id FROM film_category
        WHERE film_category.category_id =
			(SELECT category.category_id FROM category
            WHERE category.category_id = 8));

-- 5.Get name and email from customers from Canada using subqueries. Do the same with joins. Note that 
-- to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
-- that will help you get the relevant information.

SELECT first_name, last_name, email FROM customer
	WHERE address_id IN
    (SELECT address_id FROM address
		WHERE city_id IN
        (SELECT city_id FROM city
				WHERE country_id in
                (SELECT country_id FROM country
				WHERE country.country = 'Canada')));       
        
-- 6.Which are films starred by the most prolific actor? Most prolific actor is defined as the actor 
-- that has acted in the most number of films. First you will have to find the most prolific actor and 
-- then use that actor_id to find the different films that he/she starred.

SELECT film.title FROM film
WHERE film.film_id IN
  (SELECT film_actor.film_id FROM film_actor
   WHERE film_actor.actor_id =
     (SELECT actor_id FROM film_actor 
      GROUP BY actor_id ORDER BY COUNT(*) DESC LIMIT 1));

-- 7.Films rented by most profitable customer. You can use the customer table and payment table to
--  find the most profitable customer ie the customer that has made the largest sum of payments

SELECT film.title FROM film
WHERE film_id in
	(SELECT inventory.film_id FROM inventory
    WHERE inventory_id IN
    (SELECT inventory_id FROM rental
		WHERE customer_id =
			(SELECT customer_id FROM payment 
			GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 1)));

-- 8.Get the `client_id` and the `total_amount_spent` of those clients who spent more than the 
-- average of the `total_amount` spent by each client. 
-- CHATGPT HAS HELPED ME

SELECT customer_id, SUM(amount) AS total_amount_spent FROM payment
WHERE customer_id IN
	(SELECT customer_id FROM payment
		GROUP BY customer_id
		HAVING SUM(amount) >
        (SELECT AVG(total_amount) FROM
        (SELECT customer_id, SUM(amount) AS total_amount
            FROM payment
            GROUP BY customer_id) AS payment_totals))
GROUP BY customer_id;

