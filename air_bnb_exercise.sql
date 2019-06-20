---What's the most expensive listing? What else can you tell me about the listing?
SELECT
	l.id,
	l.name,
	l.neighbourhood,
	l.room_type,
	l.minimum_nights,
	l.availability_365,
	r.review_date,
	r.comments,
	max(l.price) Most_expensive
FROM
	sfo_listings l
Join
	sfo_reviews r
On
	l.id = r.id
GROUP BY 1,2,3,4,5,6,7,8
ORDER BY 9 desc
LIMIT 2;

------------------------------------------------------	
SELECT
	l.id,
	l.name,
	l.number_of_reviews,
	max(l.price) Most_expensive
FROM
	sfo_listings l
group by 1,2,3
order by 4 desc
limit 3;
---------------------------------------------------------
--What neighborhoods seem to be the most popular
WITH
	Ocupancy_full AS(
SELECT
c.listing_id
c.available
COUNT(CASE WHEN available=f then 1 END) Listing_full
FROM sfo_calender c
Group BY 1)
Select

	