USE sakila;

-- Q1
SELECT title, COUNT(inventory_id) FROM inventory
JOIN film ON film.film_id = inventory.film_id
	WHERE title = "Hunchback Impossible";

-- Q2
SELECT title FROM film
	WHERE length >
(SELECT AVG(length) FROM film);

-- Q3 REFAZER
SELECT first_name, last_name FROM actor
WHERE actor_id IN
(SELECT actor_id FROM film
	WHERE film_id IN
    (SELECT film_id FROM film
		WHERE title = "Alone Trip"));

-- Q4
SELECT title FROM film
    WHERE film_id IN
    (SELECT film_id FROM film_category
		WHERE category_id IN
		(SELECT category_id FROM category
			WHERE name LIKE'%Family%'));
    
-- Q5
SELECT first_name, last_name, email FROM customer
	WHERE address_id in
	(SELECT address_id FROM address
		WHERE city_id in
        (SELECT city_id FROM city
			WHERE country_id in
			(SELECT country_id FROM country
				WHERE country = 'CANADA')));
-- ALTERNATIVE
SELECT first_name, last_name, email FROM customer
	JOIN address ON address.address_id = customer.address_id
    JOIN city ON city.city_id = address.city_id
    JOIN country ON country.country_id = city.country_id
		WHERE country = 'CANADA';
        
-- Q6
SELECT title FROM film
	WHERE film_id IN
    (SELECT film_id FROM film_actor
		WHERE actor_id IN
        (SELECT actor_id FROM
		(SELECT actor_id, COUNT(film_id) as count_film FROM film_actor
			GROUP BY actor_id ORDER BY count_film DESC LIMIT 1) as actor_top));

-- Q7
SELECT title FROM film
	WHERE film_id IN 
    (SELECT film_id FROM inventory
		WHERE inventory_id IN
			(SELECT inventory_id FROM rental
				WHERE customer_id IN
                (SELECT customer_id FROM
				(SELECT customer_id, SUM(AMOUNT) as conta FROM payment
					GROUP BY customer_id ORDER BY conta DESC LIMIT 1) AS customer_top)));

-- Q8
SELECT customer_id, SUM(amount) AS conta FROM payment 
	GROUP BY customer_id HAVING conta > (SELECT AVG(conta) FROM 
	(SELECT customer_id, SUM(amount) as conta FROM payment
		GROUP BY customer_id) as tabla);