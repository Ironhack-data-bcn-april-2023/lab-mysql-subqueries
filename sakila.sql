USE sakila;
-- How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT COUNT(inventory.film_id) AS copies
FROM inventory
JOIN film
ON inventory.film_id=film.film_id
WHERE film.title="Hunchback Impossible"

-- List all films whose length is longer than the average of all the films.


SELECT title, length 
FROM film
WHERE length>
(SELECT avg(film.length) as average 
FROM film)



-- Use subqueries to display all actors who appear in the film Alone Trip


SELECT first_name, last_name from actor
WHERE actor_id in
    (SELECT actor_id from film_actor
        WHERE film_id = 
        (SELECT film_id from film
            WHERE title = "Alone Trip")); 


-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT title FROM film
WHERE film_id in
 (SELECT film_id from film_category
 WHERE category_id=
 (SELECT category_id from category
 WHERE name="Family"))
 
 -- Get name and email from customers from Canada using subqueries. 
 -- Do the same with joins. Note that to create a join, you will have to identify 
 -- the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

SELECT first_name, email FROM customer
WHERE address_id in
 (SELECT address_id from address
 WHERE city_id IN
 (SELECT city_id from city
 WHERE country_id IN
 (SELECT country_id from country
 WHERE country= "Canada")))

-- Which are films starred by the most prolific actor? 
-- Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find 
-- the different films that he/she starred.

SELECT title FROM film
WHERE film_id in
    (SELECT film_id from film_actor
    WHERE actor_id =
        (SELECT actor_id FROM film_actor
        WHERE film_id IN
            (SELECT COUNT(film_id) FROM film
            ORDER BY COUNT(film_id) DESC)
            LIMIT 1));

-- Films rented by most profitable customer. You can use the customer table and payment table to 
-- find the most profitable customer ie the customer that has made the largest sum of payments film, inventory, rental 

SELECT title FROM film
WHERE film_id in
    (SELECT film_id from inventory 
    WHERE inventory_id in
        (SELECT inventory_id FROM rental
        WHERE customer_id =
            (SELECT customer_id FROM payment
            GROUP BY customer_id
            ORDER BY sum(amount) DESC
            limit 1)));

-- Get the client_id and the total_amount_spent of those clients who spent more than 
-- the average of the total_amount spent by each client.




SELECT customer_id, SUM(amount) AS total_per_client FROM payment
GROUP BY customer_id
HAVING total_per_client >
(SELECT AVG(total_per_client) FROM 
                    (SELECT customer_id, SUM(amount) AS total_per_client FROM payment
                    GROUP BY customer_id) AS table_total_per_client); 

