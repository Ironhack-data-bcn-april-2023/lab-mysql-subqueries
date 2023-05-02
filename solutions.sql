USE sakila;

-- 01. How many copies of the film Hunchback Impossible exist in the inventory system?

	-- Join
SELECT film.title, COUNT(*) as num_copies 
	FROM inventory
		JOIN film ON inventory.film_id = film.film_id
		WHERE film.title = 'Hunchback Impossible';
        
	-- Subquery       
SELECT film.title, subquery.num_copies
	FROM film
		JOIN 
			
            (SELECT inventory.film_id, COUNT(*) AS num_copies
				FROM inventory
					GROUP BY inventory.film_id ) AS subquery ON film.film_id = subquery.film_id
	
    WHERE film.title = 'Hunchback Impossible';
    

-- 02. List all films whose length is longer than the average of all the films.
SELECT film.title, film.length
	FROM film
		JOIN 
			(SELECT AVG(length) AS avg_length
			FROM film) AS subquery # AVG is 115,2720
	WHERE film.length > subquery.avg_length
	ORDER BY length DESC;
    
    
-- 03. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT actor.first_name, actor.last_name
	FROM actor
		WHERE actor.actor_id IN 
        
			(SELECT film_actor.actor_id
				FROM film_actor
					WHERE film_actor.film_id = 
				
						(SELECT film.film_id
							FROM film
								WHERE film.title = 'Alone Trip'))
                            
		ORDER BY actor.first_name ASC;


-- 04. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
SELECT film.title
	FROM film
		WHERE film.film_id IN
        
			(SELECT film_category.film_id
				FROM film_category
					WHERE film_category.category_id =
					
						(SELECT category.category_id
							FROM category
								WHERE category.`name` = "Children"))
                                
		ORDER BY film.title ASC;

			
-- 05. Get name and email from customers from Canada using subqueries. Do the same with joins. N
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.


	-- Subqueries
SELECT * FROM customer;

SELECT customer.first_name, customer.last_name, customer.email
	FROM customer
		WHERE customer.address_id IN 
			
		   (SELECT address.address_id
				FROM address
					WHERE address.city_id IN 
						
						(SELECT city.city_id
							FROM city
								WHERE city.country_id = 
								
									(SELECT country.country_id
										FROM country
											WHERE country.country = 'Canada')))
		ORDER BY customer.first_name ASC;


	-- Joins
SELECT customer.first_name, customer.email
	FROM customer
		JOIN address
			ON customer.address_id = address.address_id
		JOIN city
			ON address.city_id = city.city_id
		JOIN country
			ON city.country_id = country.country_id
	WHERE country.country = "Canada"
	ORDER BY customer.first_name ASC;

-- 06. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
	-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

	-- most profitable actor is: Actor_id = 107, num_films = 42
SELECT actor_id, COUNT(*) as num_films
FROM film_actor
GROUP BY actor_id
ORDER BY num_films DESC
LIMIT 1;

    
SELECT film.title
	FROM film_actor
	JOIN
		(SELECT actor_id
			FROM 
				(SELECT actor_id, COUNT(*) as num_films
					FROM film_actor
						GROUP BY actor_id
						ORDER BY num_films DESC
								LIMIT 1) AS subquery) 
                                
			AS prol_actor ON film_actor.actor_id = prol_actor.actor_id
	JOIN film 
	ON film_actor.film_id = film.film_id;
    
-- 07. Films rented by most profitable customer. 
-- You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
    
		-- Customer id = 526, total:payments = 221,55
SELECT customer_id, SUM(amount) as total_payments
			FROM payment
				GROUP BY customer_id
				ORDER BY total_payments DESC
						LIMIT 1;


-- 08. Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.
	-- ***rental, inventory, film
