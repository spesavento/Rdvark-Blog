-- https://sqlzoo.net/wiki/SQL_Tutorial

-- 1. List the films where the yr is 1962 [Show id, title]
SELECT id, title FROM movie
WHERE yr = 1962;

-- 2. Give year of 'Citizen Kane'.
SELECT yr FROM movie
WHERE title = 'Citizen Kane';

-- 3. List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in
-- the title). Order results by year.
SELECT id, title, yr FROM movie
WHERE title LIKE '%star trek%'
ORDER BY yr;

-- 4. What id number does the actor 'Glenn Close' have?
SELECT id FROM actor
WHERE name = 'Glenn Close';

-- 5. What is the id of the film 'Casablanca'?
SELECT DISTINCT movieid FROM casting JOIN movie ON(movieid=id)
WHERE title = 'Casablanca';

-- 6. Obtain the cast list for 'Casablanca'. Use movieid=11768.
SELECT actor.name FROM actor JOIN casting ON(actorid=id)
WHERE casting.movieid = 11768;

-- 7. Obtain the cast list for the film 'Alien'.
SELECT actor.name FROM actor JOIN casting ON(id=actorid)
WHERE casting.movieid = (SELECT DISTINCT movieid FROM casting JOIN movie
ON(movieid=id) WHERE title = 'Alien');

-- 8. List the films in which 'Harrison Ford' has appeared.
SELECT title FROM movie JOIN casting ON(movie.id = casting.movieid)
WHERE casting.actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford');

-- 9. List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting
-- gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT title FROM movie JOIN casting ON(movie.id = casting.movieid)
WHERE casting.actorid = (SELECT id FROM actor WHERE name = 'Harrison Ford' AND
ord != 1);

-- 10. List the films together with the leading star for all 1962 films.
SELECT movie.title, actor.name FROM movie JOIN casting ON(movie.id =
casting.movieid) JOIN actor ON(casting.actorid = actor.id)
WHERE movie.yr = 1962 AND ord = 1;

-- 11. Which were the busiest years for 'John Travolta', show the year and the number of movies he made each
-- year for any year in which he made more than 2 movies.
SELECT yr, COUNT(title) AS num_movies FROM movie JOIN casting ON movie.id=movieid JOIN actor ON actorid=actor.id
WHERE name = 'John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM (SELECT yr,COUNT(title) AS c FROM movie
JOIN casting ON movie.id=movieid JOIN actor ON actorid=actor.id
WHERE name='John Travolta'
GROUP BY yr) AS t);

-- 12. List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name FROM movie JOIN casting x ON movie.id = movieid JOIN actor ON actor.id =actorid
WHERE ord = 1 AND movieid IN(SELECT movieid FROM casting y JOIN actor ON
(y.actorid = actor.id)
WHERE actor.name='Julie Andrews')
13. Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
SELECT DISTINCT name FROM actor JOIN casting ON(actor.id = casting.actorid)
WHERE (SELECT COUNT(ord) FROM casting WHERE casting.actorid = actor.id AND ord = 1) >= 30
ORDER BY name;

-- 14. List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
SELECT movie.title, COUNT(casting.actorid) AS num_cast FROM movie JOIN casting
ON(movie.id = casting.movieid)
WHERE movie.yr = 1978
GROUP BY movie.title
ORDER BY num_cast DESC, movie.title;

-- 15. List all the people who have worked with 'Art Garfunkel'.
SELECT DISTINCT name FROM actor JOIN casting ON(actor.id = casting.actorid)
WHERE casting.movieid IN(SELECT movieid FROM casting JOIN actor ON(actorid=id)
WHERE name = 'Art Garfunkel')
AND actor.name != 'Art Garfunkel';
