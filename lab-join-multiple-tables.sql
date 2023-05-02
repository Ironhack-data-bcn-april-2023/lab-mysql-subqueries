SELECT COUNT(store_id)
	FROM Sakila.inventory
    WHERE film_id = (SELECT film_id
			FROM Sakila.film
			WHERE title = 'Hunchback Impossible');
            
SELECT length
 FROM Sakila.film
 WHERE length > (SELECT AVG(length) FROM Sakila.film)
 ORDER BY length ASC;
 
SELECT first_name, last_name
	FROM Sakila.actor
	WHERE actor_id IN (SELECT actor_id FROM Sakila.film_actor WHERE film_id =
							(SELECT film_id FROM Sakila.film WHERE title = 'Alone Trip'));
                            
SELECT title
	FROM Sakila.film
	WHERE film_id in (SELECT film_id FROM Sakila.film_category WHERE category_id =
							(SELECT category_id FROM Sakila.category WHERE name = 'Family'));

SELECT first_name, last_name, email
	FROM Sakila.customer
	WHERE address_id in (SELECT address_id FROM Sakila.address WHERE city_id in
							(SELECT city_id FROM Sakila.city WHERE country_id in 
                            (SELECT country_id FROM Sakila.country WHERE country = "Canada")));

SELECT title
	FROM Sakila.film
    WHERE film_id IN (SELECT film_id FROM Sakila.film_actor WHERE actor_id = 
					 (SELECT actor_id FROM Sakila.film_actor WHERE film_id IN
                     (SELECT COUNT(film_id) FROM Sakila.film ORDER BY COUNT(film_id) DESC)
                     LIMIT 1));
                
SELECT customer.first_name, customer.last_name, SUM(payment.amount) as total_payments
	FROM Sakila.customer
	INNER JOIN Sakila.payment ON customer.customer_id = payment.customer_id
	GROUP BY customer.customer_id
	ORDER BY total_payments DESC
	LIMIT 1;
                
                
                

