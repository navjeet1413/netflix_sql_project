-- Netflix Data Analysis using SQL
-- Solutions of 15 business problems
-- 1. Count the number of Movies vs TV Shows

SELECT type,COUNT(*) 
FROM netflix 
GROUP BY type;


-- 2. Find the most common rating for movies and TV shows

SELECT type,rating AS CommonRating,COUNT(*) as CountRating 
FROM netflix 
GROUP BY type,rating 
HAVING CountRating IN (
    SELECT MAX(CountRating) 
    FROM (
        SELECT type,rating,COUNT(*) as CountRating 
        FROM netflix 
        GROUP BY type,rating) as NewTable 
        GROUP BY type
    );


-- 3. List all movies released in a specific year (e.g., 2020)

SELECT title AS Movies 
FROM netflix 
WHERE type="Movie" AND release_year='2020';


-- 4. Find the top 5 countries with the most content on Netflix

SELECT Country,COUNT(*) AS totalContent 
FROM netflix 
GROUP BY Country 
HAVING country<>"" 
ORDER BY totalContent DESC LIMIT 5;


-- 5. Identify the longest movie

SELECT title AS movies 
FROM netflix 
WHERE type="Movie" AND duration = (SELECT MAX(duration) FROM netflix);


-- 6. Find content added in the last 5 years

SELECT * 
FROM netflix 
WHERE EXTRACT(YEAR FROM date_added) >= EXTRACT(YEAR FROM DATE(CURRENT_DATE))-5;


-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

SELECT * 
FROM netflix 
WHERE director='Rajiv Chilaka';


-- 8. List all TV shows with more than 5 seasons

SELECT title AS Tv_Shows 
FROM netflix 
WHERE type='TV Show' AND duration > '5 Seasons';


-- 9. Count the number of content items in each genre

SELECT listed_in As Genre, COUNT(*) AS CountContent 
FROM netflix 
GROUP BY listed_in;


-- 10. Find each year and the average numbers of content release by India on netflix. 
-- return top 5 year with highest avg content release !

SELECT release_year,COUNT(*) AS CountContent 
FROM netflix 
WHERE Country='India'
GROUP BY release_year 
ORDER BY CountContent DESC LIMIT 5;


-- 11. List all movies that are documentaries

SELECT * 
FROM netflix
WHERE listed_in LIKE '%Documentaries';


-- 12. Find all content without a director

SELECT * 
FROM netflix
WHERE director="";


-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

SELECT * 
FROM netflix
WHERE 
casts LIKE '%Salman Khan%' AND release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;


-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actor,
	COUNT(*)
FROM netflix
WHERE country = 'India'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10

	
/*
Question 15:
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/

SELECT Category,Count(movies) AS CountMovies 
FROM(
SELECT title AS movies, IF(description LIKE '%Kill%','bad','good') As category FROM netflix) AS newtable
GROUP BY category;


-- End of reports

