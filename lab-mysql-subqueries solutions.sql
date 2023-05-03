Use sakila;

Select count(inventory.film_id) from inventory join film on film.film_id = inventory.film_id where title = "Hunchback Impossible";

Select title from film where length > (Select avg(length) as avg_lenght from film);

Select first_name, last_name from actor where actor_id in (select actor_id from film_actor where film_id = (select film_id from film where title = 'Alone Trip'));

Select title from film where film_id in (select film_id from film_category where category_id = (select category_id from category where name = "family"));

Select first_name, email from customer join address on customer.address_id = address.address_id join city on address.city_id = city.city_id join country on city.country_id = country.country_id where country.country = 'Canada';

Select title from film where film_id in (select film_id from film_actor where actor_id = (select actor_id from film_actor where film_id in (select count(film_id) from film order by count(film_id) desc) limit 1));

Select title from film where film_id in (select film id from

