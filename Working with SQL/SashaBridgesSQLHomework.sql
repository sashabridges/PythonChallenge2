<<<<<<< HEAD
USE sakila;
-- * 1a. Display the first and last names of all actors from the table `actor`.
SELECT first_name, last_name FROM actor;

-- * 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
SELECT  CONCAT(first_name, ' ', last_name) AS 'Actor Name'
FROM actor;

-- * 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- * 2b. Find all actors whose last name contain the letters `GEN`:
SELECT first_name, last_name
FROM actor
WHERE last_name like '%GEN%';

-- * 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

SELECT last_name, first_name
FROM actor
WHERE last_name like '%LI%'
ORDER BY last_name;

-- * 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, county
FROM actor
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- * 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).
ALTER TABLE actor 
ADD 'description' BLOB;

-- * 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.
ALTER TABLE actor
DROP COLUMN description;

-- * 4a. List the last names of actors, as well as how many actors have that last name.

SELECT last_name, count(last_name) AS 'Count'
FROM actor;

-- * 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT last_name, COUNT(last_name) AS 'Count_of_Last'
FROM actor
WHERE Count_of_Last >= 2;

-- * 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
UPDATE actor
SET first_name = 'HARPO', last_name = 'WILLIAMS'
WHERE first_name = 'GROUCHO', last_name = 'WILLIAMS';

-- * 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO';

-- * 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
CREATE TABLE address (
	address_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	address VARCHAR NOT NULL,
	address2 VARCHAR,
	district VARCHAR,
	city_id SMALLINT(5) FOREIGN KEY REFERENCES city(city_id),
	postal_code VARCHAR(10),
	phone VARCHAR(10),
	last_update TIMESTAMP
);

  -- * Hint: [https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)

-- * 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address
ON address.address_id = staff.address_id;

-- * 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
SELECT staff.first_name, staff.last_name, payment.amount
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08%';

-- * 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
SELECT film.title , count(film_actor.film_id) AS 'Actor Count'
FROM film_actor
INNER JOIN film
ON film_actor.film_id = film.film_id
GROUP BY film.title;

-- * 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
SELECT * FROM inventory
WHERE film_id IN (
	SELECT film_id FROM film WHERE title = 'Hunchback Impossible'
);



-- * 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT customer.last_name, sum(payment.amount)
FROM customer
JOIN payment
ON customer.customer_id = payment.payment_id
GROUP BY customer.last_name
ORDER BY customer.last_name ASC;
  -- ![Total amount paid](Images/total_payment.png)

-- * 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
-- Titles of movies starting w/ Letters K and Q (set w/ film table)
-- Language English (set w/ language table)
-- title, language_id from film
-- language_id from language, film

SELECT title
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = "English"
)  
AND 
(title LIKE 'K%' OR title LIKE 'Q%');

-- * 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
SELECT first_name, last_name FROM actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor
	WHERE film_id IN (
		SELECT film_id FROM film
		WHERE title = 'Alone Trip'
	)
);

-- * 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
-- first_name, last_name, email
-- address_id from customer, address
-- city_id from address, city
-- country_id from country, city
-- country from country
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT country_id
		FROM city
		WHERE country_id IN (
			SELECT country
			FROM country
			WHERE country = "Canada"
		)
	)
)
GROUP BY email;




-- * 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.
-- category: name, category_id
-- film_category: film_id, category_id

-- category: name, category_id
-- film_category: film_id, category_id
-- inventory: film_id, inventory_id
-- payment: payment_id, amount
-- rental:  inventory_id, rental_id

SELECT film.title
FROM film
JOIN film_category
ON film.film_id = film_category.film_id
WHERE film.film_id IN (
	SELECT film_category.film_id FROM film_category
	JOIN category
	ON film_category.category_id = category.category_id
	WHERE  category.name = 'family'
)


-- * 7e. Display the most frequently rented movies in descending order.
SELECT f.title, count(r.rental_id) AS 'Rental Amount'
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY DESC;

-- * 7f. Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, sum(p.amount) as 'Gross Amount'
FROM store s
JOIN payment p
ON s.manager_staff_id = p.staff_id;



-- * 7g. Write a query to display for each store its store ID, city, and country.
-- storeID from store
-- address_id from address, store
-- city_id from address, city
-- country_id from city, country
-- country name

SELECT country, city, store_id
FROM country
WHERE city_id IN (
	SELECT city_id, store_id
	FROM city
	WHERE store_id IN (
		SELECT store_id
		FROM store
	)
);

-- * 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
-- category, film_category, inventory, payment, rental
-- category: name, category_id
-- film_category: film_id, category_id
-- inventory: film_id, inventory_id
-- payment: payment_id, amount
-- rental:  inventory_id, rental_id

SELECT category.name, sum(payment.amount) AS 'Gross Revenue'
FROM payment
JOIN rental
ON payment.customer_id = rental.customer_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
JOIN film
ON inventory.film_id = film.film_id
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY 'Gross Revenue' DESC
LIMIT 5;


-- * 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW executive_view AS
SELECT category.name, sum(payment.amount) AS 'Gross Revenue'
FROM payment
JOIN rental
ON payment.customer_id = rental.customer_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
JOIN film
ON inventory.film_id = film.film_id
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY 'Gross Revenue' DESC
LIMIT 5;

-- * 8b. How would you display the view that you created in 8a?
SELECT * FROM executive_view;
-- * 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
=======
USE sakila;
-- * 1a. Display the first and last names of all actors from the table `actor`.
SELECT first_name, last_name FROM actor;

-- * 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`.
SELECT  CONCAT(first_name, ' ', last_name) AS 'Actor Name'
FROM actor;

-- * 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- * 2b. Find all actors whose last name contain the letters `GEN`:
SELECT first_name, last_name
FROM actor
WHERE last_name like '%GEN%';

-- * 2c. Find all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

SELECT last_name, first_name
FROM actor
WHERE last_name like '%LI%'
ORDER BY last_name;

-- * 2d. Using `IN`, display the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:
SELECT country_id, county
FROM actor
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- * 3a. You want to keep a description of each actor. You don't think you will be performing queries on a description, so create a column in the table `actor` named `description` and use the data type `BLOB` (Make sure to research the type `BLOB`, as the difference between it and `VARCHAR` are significant).
ALTER TABLE actor 
ADD 'description' BLOB;

-- * 3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the `description` column.
ALTER TABLE actor
DROP COLUMN description;

-- * 4a. List the last names of actors, as well as how many actors have that last name.

SELECT last_name, count(last_name) AS 'Count'
FROM actor;

-- * 4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT last_name, COUNT(last_name) AS 'Count_of_Last'
FROM actor
WHERE Count_of_Last >= 2;

-- * 4c. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`. Write a query to fix the record.
UPDATE actor
SET first_name = 'HARPO', last_name = 'WILLIAMS'
WHERE first_name = 'GROUCHO', last_name = 'WILLIAMS';

-- * 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. It turns out that `GROUCHO` was the correct name after all! In a single query, if the first name of the actor is currently `HARPO`, change it to `GROUCHO`.
UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO';

-- * 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it?
CREATE TABLE address (
	address_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	address VARCHAR NOT NULL,
	address2 VARCHAR,
	district VARCHAR,
	city_id SMALLINT(5) FOREIGN KEY REFERENCES city(city_id),
	postal_code VARCHAR(10),
	phone VARCHAR(10),
	last_update TIMESTAMP
);

  -- * Hint: [https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html](https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html)

-- * 6a. Use `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address
ON address.address_id = staff.address_id;

-- * 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`.
SELECT staff.first_name, staff.last_name, payment.amount
FROM staff
JOIN payment
ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08%';

-- * 6c. List each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
SELECT film.title , count(film_actor.film_id) AS 'Actor Count'
FROM film_actor
INNER JOIN film
ON film_actor.film_id = film.film_id
GROUP BY film.title;

-- * 6d. How many copies of the film `Hunchback Impossible` exist in the inventory system?
SELECT * FROM inventory
WHERE film_id IN (
	SELECT film_id FROM film WHERE title = 'Hunchback Impossible'
);



-- * 6e. Using the tables `payment` and `customer` and the `JOIN` command, list the total paid by each customer. List the customers alphabetically by last name:
SELECT customer.last_name, sum(payment.amount)
FROM customer
JOIN payment
ON customer.customer_id = payment.payment_id
GROUP BY customer.last_name
ORDER BY customer.last_name ASC;
  -- ![Total amount paid](Images/total_payment.png)

-- * 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters `K` and `Q` have also soared in popularity. Use subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English.
-- Titles of movies starting w/ Letters K and Q (set w/ film table)
-- Language English (set w/ language table)
-- title, language_id from film
-- language_id from language, film

SELECT title
FROM film
WHERE language_id IN (
	SELECT language_id
	FROM language
	WHERE name = "English"
)  
AND 
(title LIKE 'K%' OR title LIKE 'Q%');

-- * 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
SELECT first_name, last_name FROM actor
WHERE actor_id IN (
	SELECT actor_id FROM film_actor
	WHERE film_id IN (
		SELECT film_id FROM film
		WHERE title = 'Alone Trip'
	)
);

-- * 7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
-- first_name, last_name, email
-- address_id from customer, address
-- city_id from address, city
-- country_id from country, city
-- country from country
SELECT first_name, last_name, email
FROM customer
WHERE address_id IN (
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT country_id
		FROM city
		WHERE country_id IN (
			SELECT country
			FROM country
			WHERE country = "Canada"
		)
	)
)
GROUP BY email;




-- * 7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as _family_ films.
-- category: name, category_id
-- film_category: film_id, category_id

-- category: name, category_id
-- film_category: film_id, category_id
-- inventory: film_id, inventory_id
-- payment: payment_id, amount
-- rental:  inventory_id, rental_id

SELECT film.title
FROM film
JOIN film_category
ON film.film_id = film_category.film_id
WHERE film.film_id IN (
	SELECT film_category.film_id FROM film_category
	JOIN category
	ON film_category.category_id = category.category_id
	WHERE  category.name = 'family'
)


-- * 7e. Display the most frequently rented movies in descending order.
SELECT f.title, count(r.rental_id) AS 'Rental Amount'
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY DESC;

-- * 7f. Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, sum(p.amount) as 'Gross Amount'
FROM store s
JOIN payment p
ON s.manager_staff_id = p.staff_id;



-- * 7g. Write a query to display for each store its store ID, city, and country.
-- storeID from store
-- address_id from address, store
-- city_id from address, city
-- country_id from city, country
-- country name

SELECT country, city, store_id
FROM country
WHERE city_id IN (
	SELECT city_id, store_id
	FROM city
	WHERE store_id IN (
		SELECT store_id
		FROM store
	)
);

-- * 7h. List the top five genres in gross revenue in descending order. (**Hint**: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
-- category, film_category, inventory, payment, rental
-- category: name, category_id
-- film_category: film_id, category_id
-- inventory: film_id, inventory_id
-- payment: payment_id, amount
-- rental:  inventory_id, rental_id

SELECT category.name, sum(payment.amount) AS 'Gross Revenue'
FROM payment
JOIN rental
ON payment.customer_id = rental.customer_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
JOIN film
ON inventory.film_id = film.film_id
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY 'Gross Revenue' DESC
LIMIT 5;


-- * 8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
CREATE VIEW executive_view AS
SELECT category.name, sum(payment.amount) AS 'Gross Revenue'
FROM payment
JOIN rental
ON payment.customer_id = rental.customer_id
JOIN inventory
ON rental.inventory_id = inventory.inventory_id
JOIN film
ON inventory.film_id = film.film_id
JOIN film_category
ON film.film_id = film_category.film_id
JOIN category
ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY 'Gross Revenue' DESC
LIMIT 5;

-- * 8b. How would you display the view that you created in 8a?
SELECT * FROM executive_view;
-- * 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
>>>>>>> 41f04f26db7a60bd1492dacf68c48546e3a5af9c
DROP VIEW executive_view;