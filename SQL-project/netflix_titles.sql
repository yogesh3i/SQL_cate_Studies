create database Netflix;
use Netflix;
show tables;
SELECT * FROM netflix_titles;

-- Exploratory data analysis:

-- Question-1: What is the distribution of the type of content in dataset ?

SELECT type,count(title) from netflix_titles
GROUP BY type;

-- Conclusion:
 /* There are two type of shows in the given dataset TV shows and Movie with ratio of 1:3. */
 
 -- Question-2: How many unique titles present in the dataset ?
 
 SELECT count(distinct title) AS unique_titles from netflix_titles;
 
 -- Conclusion:
 /* There are total 20 unique titles in the dataset. */
 
 
 -- Question 3: What are the top 10 contries with highiest number of titles ?
 
 SELECT Country,count(title) as number_title from netflix_titles
 GROUP BY country 
 ORDER BY number_title DESC
 LIMIT 10;

-- Conclusion:
/* Amoung all the contries present in the dataset United states,India and Mexico has the max number of titles 
present in there contries. */

-- Question-4: What is the distribution of content rating ?
SELECT * FROM netflix_titles;

SELECT rating,count(title) as Dist 
FROM netflix_titles
GROUP BY rating;

-- Conclusion:
/* TV-MA is the rating given mostly.*/

-- Content analysis:

-- Question-5: Who are the top 10 directors with the highest number of titles on the platform? 
SELECT * FROM netflix_titles;

SELECT director,count(title) as num_of_til 
FROM netflix_titles
GROUP BY director
ORDER BY num_of_til DESC
LIMIT 10;

-- Conclusion:
/* The director who has most number of title in there list is not given in the list.*/

-- Question-6: What are the top 10 most common cast members across all titles?

SELECT cast,count(*) as Number_cast 
FROM netflix_titles 
GROUP BY cast 
ORDER BY Number_cast DESC
LIMIT 10;

-- Conclusion:
/* The topest cast is having count of 1 only8*/

-- Question-7:How many titles have been added to the platform each year?

SELECT * FROM netflix_titles;

SELECT release_year,count(*) as title_added 
FROM netflix_titles 
GROUP BY release_year 
ORDER BY title_added DESC
LIMIT 10;

-- Conclusion:
/* The year 2019 is the year in which the titles are added more in number8 */

  -- Question-8: What are the oldest and newest titles available on the platform?
  
  SELECT * FROM netflix_titles;
  
SELECT type,title,min(release_year) AS oldest_title_added, MAX(release_year) AS newest_title_added 
FROM netflix_titles;

-- Conclusion:
/* The newest title added to the platform was in 2020 and the oldest was added in the year of 1997.*/

-- Trends and insights: 

-- Question-9: Is there any correlation between the release year of a title and its rating?

SELECT * FROM netflix_titles;

SELECT release_year,rating,count(*) AS count 
FROM netflix_titles 
GROUP BY release_year
ORDER BY COUNT DESC;

-- Conclusion:
/* There is no as such direct relaton between the release_year and rating but from the result 
we can see that the in which year what was the rating given most.*/

-- Question-10: Are there any trends in the duration (runtime) of content over the years?

SELECT * FROM netflix_titles;

SELECT release_year, AVG(duration) as Avg_diration_per_year 
FROM netflix_titles 
GROUP BY release_year
ORDER BY  Avg_diration_per_year ASC;

-- Conclusion: From the result appeared we can say that the average of the duration is changing every year by year.

-- Questoin-11: Do certain genres dominate the platform, and how have their popularity changed over time?

SELECT * FROM netflix_titles;

SELECT listed_in,count(*) as Count 
FROM netflix_titles
GROUP BY listed_in
ORDER BY Count DESC;

-- Question-12: Is there any relationship between the country of production and the rating of the content?

SELECT * FROM netflix_titles;

SELECT country,rating,count(rating) as Count 
FROM netflix_titles 
GROUP BY country
ORDER BY Count DESC;

-- Conclusion: From the data we can say the rating is changing with country name if its US most of the rating given is PG-13. 

-- User preferences 

-- Question-13: What are the top 10 most popular genres among users?
SELECT * FROM netflix_titles;

SELECT listed_in,count(*) as most_prefered 
FROM netflix_titles 
GROUP BY listed_in
ORDER BY most_prefered DESC
LIMIT 10;

-- Queston-14: Is there a correlation between the duration of a title and its rating?

SELECT * FROM netflix_titles;

SELECT duration, rating, count(*) as count
FROM netflix_titles
GROUP BY duration, rating
ORDER BY count DESC;

-- Conclusion: There is no as such correlation between the duration and rating.

-- Question-15: Are there any specific countries that prefer certain types of content (e.g., movies vs. TV shows)?

SELECT * FROM netflix_titles;

SELECT country,type, count(*) as Prefered_content
FROM netflix_titles 
GROUP BY country,type 
ORDER BY Prefered_content DESC;


-- Description Analysis:

-- Question- 16: Are there any specific genres or themes associated with titles that receive high ratings?

SELECT listed_in,rating,count(*) as COUNT 
FROM netflix_titles 
WHERE rating = 'High rating'
GROUP BY listed_in,rating;

-- ConclusioN: There is no genres rated as High Rating.

-- Question -17: Is there any relationship between the length of the description and the rating of the title?

SELECT * FROM netflix_titles;

SELECT length(description) as DESCR,rating,count(*) AS ct
FROM netflix_titles
GROUP BY DESCR
ORDER BY ct DESC;


























