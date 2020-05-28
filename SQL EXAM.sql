/* 1. Write a query that allows you to inspect the schema of the naep table*/
SELECT
column_name, data_type
FROM
information_schema.columns
WHERE
table_name = 'naep';

/* 2. Write a query that returns the first 50 records of the naep table*/
SELECT 
* FROM naep LIMIT 50;

/* 3. Write a query that returns summary statistics (count, average, min, and max values) for avg_math_4_score by state.
Make sure to sort the results alphabetically by state name*/
SELECT state,
count(avg_math_4_score),
avg(avg_math_4_score),
min(avg_math_4_score),
max(avg_math_4_score)
FROM naep
GROUP BY state
ORDER BY state;

/* 4. Write a query that alters the previous query so that it returns only the summary statistics for avg_math_4_score
   by state with differences in max and min values that are greater than 30*/   
SELECT state,
count(avg_math_4_score),
avg(avg_math_4_score),
min(avg_math_4_score),
max(avg_math_4_score)
FROM naep
GROUP BY state
HAVING MAX(avg_math_4_score)- MIN(avg_math_4_score)> 30
ORDER BY state;

WITH naep as (select state,
count(avg_math_4_score) as count,
avg(avg_math_4_score) as avg,
min(avg_math_4_score)as min,
max(avg_math_4_score)as max,
(max(avg_math_4_score)- min(avg_math_4_score)) as diff
FROM naep
GROUP by state
ORDER by diff)
SELECT * from naep where diff>30;

/* 5. Write a query that returns a field called bottom_10_states that lists the states in the bottom 10
   for avg_math_4_score in the year 2000*/
SELECT state AS bottom_10_states
FROM naep
WHERE year = '2000' AND avg_math_4_score IS NOT NULL
Order By avg_math_4_score LIMIT 10;

/* 6. Write a query that calculates the average avg_math_4_score rounded to the nearest 2 decimal places
over all states in the year 2000.*/
SELECT
round(AVG(avg_math_4_score),2)
FROM naep
WHERE year = '2000';

/* 7. Write a query that returns a field called below_average_states_y2000 that lists all states with
   an avg_math_4_score less than the average over all states in the year 2000 (224.8) */
WITH avr_st as 
(select avg(avg_math_4_score) as avg_states
FROM naep
WHERE year = '2000'
GROUP BY state)
SELECT avg_math_4_score as below_average_states_y2000, state
FROM naep, avr_st
WHERE avg_math_4_score < avg_states;

/* 8. Write a query that returns a field called scores_missing_y2000 that lists any states with missing values in
   the avg_math_4_score column of the naep data table for the year 2000*/
SELECT state as  scores_missing_y2000
FROM naep
WHERE year = '2000' 
AND 
avg_math_4_score IS NULL;

/* 9. Write a query that returns for the year 2000 the state, avg_math_4_score, and total_expenditure from the naep
   table left outer joined with the finance table, using id as the key and ordered by total_expenditure greatest to
   least. Be sure to round avg_math_4_score to the nearest 2 decimal places, and then filter out NULL avg_math_4_scores
   in order to see any correlation more clearly.
 */

SELECT naep.state, ROUND(naep.avg_math_4_score, 2) as avg_math_4_score, finance.total_expenditure
FROM naep
LEFT OUTER JOIN finance ON naep.id = finance.id
WHERE naep.year = '2000' AND avg_math_4_score IS NOT NULL
ORDER BY finance.total_expenditure DESC;