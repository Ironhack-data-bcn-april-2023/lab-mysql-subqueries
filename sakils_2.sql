USE sakila;

-- How many distinct (different) actors' last names are there?

SELECT DISTINCT(last_name) FROM actor

-- In how many different languages where the films originally produced? (Use the column language_id from the film table)
SELECT COUNT(language_id) AS total_languages
FROM film

-- How many movies were released with "PG-13" rating?
SELECT COUNT(film_id) AS total_languages
FROM film
WHERE rating="PG-13"



-- Get 10 the longest movies from 2006.

SELECT title
FROM film
WHERE release_year=2006
ORDER BY length DESC
limit 10

-- How many days has been the company operating (check DATEDIFF() function)?

-- Show rental info with additional columns month and weekday. Get 20.

SELECT *, MONTH(rental_date), DAY(rental_date)
FROM rental
LIMIT 20


-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT *, DAYOFWEEK(rental_date) AS day_of_week, 
       CASE 
         WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
         ELSE 'workday'
       END AS day_type
FROM rental

-- How many rentals were in the last month of activity?
SELECT COUNT(rental_id) AS rental_count
FROM rental
WHERE rental_date >= DATE_SUB(NOW(), INTERVAL 1 MONTH)

-- Get film ratings.

SELECT rating from FILM

-- Get release years.
SELECT release_year from FILM

-- Get all films with APOLLO in the title

SELECT title from FILM
WHERE title REGEXP ".*APOLLO.*"

-- Get all films which title ends with APOLLO.
SELECT title from FILM
WHERE title REGEXP ".*APOLLO$"
-- Get all films with word DATE in the title.
SELECT title from FILM
WHERE title REGEXP ".*DATE.*"
-- Get 10 films with the longest title.
SELECT title, LENGTH(title) AS title_length
FROM film
ORDER BY title_length DESC
LIMIT 10

-- Get 10 the longest films.
SELECT title, length
FROM film
ORDER BY film.length DESC
LIMIT 10

-- How many films include Behind the Scenes content?

-- List films ordered by release year and title in alphabetical order.

-- Drop column picture from staff.

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. For eg., you would notice that you need customer_id information as well. To get that you can use the following query:

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- Use similar method to get inventory_id, film_id, and staff_id.

-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:

-- Check if there are any non-active users
-- Create a table backup table as suggested
-- Delete the non active users from the table customer