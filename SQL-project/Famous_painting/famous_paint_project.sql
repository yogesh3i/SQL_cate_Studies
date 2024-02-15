use painting;
select * from artist;
select * from canvas_size;
select * from image_link;
select * from museum;
select * from museum_hours;
select * from product_size;
select * from subject;
select * from work;


-- Q1. Find the name of the museum which are open on both sunday and monday,list the  name and city of museum. 

SELECT m.name,m.city,mh1.day FROM museum_hours mh1
INNER JOIN museum m using(museum_id)
WHERE day = 'Sunday'
AND EXISTS (SELECT * FROM museum_hours mh2 
			WHERE mh1.museum_id = mh2.museum_id 
            AND mh2.day = 'Monday'
            );

-- Q2 Find the museum which is open for longest duration of time list the name,state,city and day 

-- To solve this question i need to substrat open time amd close time but those are in string type so to convert it use str_to_date 

SELECT * FROM (
	SELECT m.name,m.city,m.state,mh.day,
	str_to_date(open,'%h:%i:AM') AS open_time,
	str_to_date(close,'%h:%i:PM') AS close_time,
	TIMEDIFF(str_to_date(open,'%h:%i:AM') ,str_to_date(close,'%h:%i:PM')) AS Duration,
	RANK() OVER(ORDER BY (TIMEDIFF(str_to_date(open,'%h:%i:AM') ,str_to_date(close,'%h:%i:PM'))) DESC) AS RANKK
	FROM museum_hours mh
	INNER JOIN museum m using(museum_id)) A
    WHERE RANKK = 1;
    
    
    
-- Display the city with most number of museum,output two seperate coumns to mention city and country if there are multiple values 
-- seperate them with comma. 

with cte_country AS 
	(SELECT country,count(*)
    FROM museum
	GROUP BY COUNTRY 
    ORDER BY count(*)),
	
	cte_city AS 
	(SELECT city,count(*)
    FROM museum
	GROUP BY city
    ORDER BY count(*)
    DESC )
    
SELECT country,city 
FROM cte_country 
CROSS JOIN cte_city 
LIMIT 1;


/*Q Are there museuems without any paintings?*/

SELECT * from museum M
LEFT JOIN work w ON M.museum_id = w.museum_id
WHERE w.work_id IS NULL;
	
 select * from work;
  select * from museum;
  
  
-- Q. How many paintings have an asking price of more than their regular price?

SELECT work_id,COUNT(*) as total_paiting
FROM product_size 
WHERE sale_price > regular_price 
GROUP BY work_id;

-- dentify the paintings whose asking price is less than 50% of its regular price

SELECT *
FROM product_size 
WHERE sale_price < ((regular_price)*100)/50;

-- Q Which canva size costs the most?

SELECT * FROM canvas_size;
SELECT * FROM product_size;

SELECT c.label,p.sale_price 
FROM product_size p 
INNER JOIN canvas_size c
ON p.size_id = c.size_id
GROUP BY c.label,p.sale_price
HAVING  MAX(p.sale_price)
ORDER BY p.sale_price DESC
LIMIT 1;

-- Identify the museum with invalid city details 

SELECT * FROM MUSEUM;

SELECT* from museum 
WHERE city REGEXP '^[0-9]';

-- Q  Fetch the top 10 most famous painting subject 
SELECT * FROM work;
SELECT * FROM museum;
SELECT * FROM product_size;

SELECT DISTINCT subject,count(*)
FROM subject S
GROUP BY subject
ORDER BY 2 DESC
LIMIT 10;

-- Q How many museums are open every single day?*
SELECT count(*) from (
SELECT museum_id,count(day) as Days
FROM museum_hours
group by museum_id
HAVING COUNT(day)=7) A;


-- Q A Which are the top 5 most popular museum? (Popularity is defined based on most no of paintings in a museum)

SELECT m.museum_id,m.name,count(w.work_id) as Total_painting 
FROM museum m 
INNER JOIN work w ON m.museum_id = w.museum_id
GROUP BY museum_id,name
ORDER BY Total_painting DESC
LIMIT 5;


-- Q. Who are the top 5 most popular artist? (Popularity is defined based on most no of paintings done by an artist)*/

SELECT * FROM artist;
SELECT * FROM work;
SELECT * FROM museum;

SELECT a.artist_id,a.full_name,COUNT(w.work_id) as Num_of_painting
FROM artist a 
INNER JOIN work w ON a.artist_id = w.artist_id
GROUP BY a.artist_id,a.full_name
ORDER BY Num_of_painting DESC 
LIMIT 5;


-- Q. Which museum is open for the longest during a day. Dispay museum name, state and hours open and which day?

SELECT*,(open_time-close_time) AS Duration FROM
(
SELECT m.name,m.state,mh.day,
STR_TO_DATE(open,'%h:%i:AM') as open_time, 
STR_TO_DATE(close,'%h:%i:PM') as close_time 
FROM museum_hours mh 
INNER JOIN museum m 
ON mh.museum_id = m.museum_id) A
ORDER BY Duration DESC
LIMIT 1;


-- Identify the museums which are open on both sunday and monday 

SELECT m.name,mh.day FROM museum_hours mh
INNER JOIN museum m WHERE day = 'Sunday' AND
EXISTS (SELECT m.name,mh.day FROM museum_hours mh
INNER JOIN museum WHERE day = 'Monday');


-- Q. Which museum has the most number of most pupular paintings 
SELECT m.name,w.style,count(w.style) AS num_paint 
FROM museum as m 
INNER JOIN work w 
ON m.museum_id = w.museum_id 
GROUP BY m.name,w.style
ORDER BY num_paint 
LIMIT 1;


-- Q Identify the artists whose paintings are displayed in multiple countries
SELECT * FROM work;
SELECT * FROM museum;
select * from artist;

SELECT a.full_name,a.style,count(*) num
FROM artist a
JOIN work w
ON a.artist_id = w.artist_id 
JOIN museum m 
ON w.museum_id = m.museum_id 
GROUP BY a.full_name,a.style
ORDER BY num DESC
LIMIT 5;


-- Q Which top 5 contries has most number of paintings 
SELECT m.country,count(w.work_id) AS num_pai
FROM museum m
INNER JOIN work w using(museum_id)
GROUP BY m.country
ORDER BY num_pai DESC 
LIMIT 1
OFFSET 4;

 -- Q A Which are the 3 most popular and 3 least popular painting styles?*
 
 (SELECT style,count(*) as num_pai, 'Most_popu' AS remarks
 FROM work 
 GROUP BY style 
 ORDER BY count(*) DESC
 LIMIT 3)
 UNION 
 (SELECT style,count(*) as num_pai, 'Least_popu' AS remarks
 FROM work 
 GROUP BY style 
 ORDER BY count(*)  ASC
 LIMIT 3);
 
 
 -- Q Which artist has most number of potrait paintings outside USA. 
SELECT a.full_name,a.nationality,w.style,COUNT(*) as num_po_pain
FROM artist a
INNER JOIN work w using(artist_id)
INNER JOIN museum m using(museum_id)
INNER JOIN subject USING(work_id)
WHERE m.country <> 'USA' AND 
subject = 'Portraits'
GROUP BY a.full_name,a.nationality,w.style
ORDER BY num_po_pain DESC
LIMIT 1; 

SELECT * FROM subject;







