Question 1. Understanding docker first run

docker run -it --entrypoint=bash python:3.12.8 ## Python Image
pip --version 


Question 3. Trip Segmentation Count

---1.
select COUNT(index) from green_taxi_data 
where trip_distance<=1
and lpep_pickup_datetime::DATE>=to_date('2019-10-01','yyyy-mm-dd')
and lpep_pickup_datetime::DATE<to_date('2019-11-01','yyyy-mm-dd')
and lpep_dropoff_datetime::DATE<to_date('2019-11-01','yyyy-mm-dd')

--2.

select count(index) from green_taxi_data 
where trip_distance>1 and trip_distance<=3
and lpep_pickup_datetime::DATE>=to_date('2019-10-01','yyyy-mm-dd')
and lpep_pickup_datetime::DATE<to_date('2019-11-01','yyyy-mm-dd')
and lpep_dropoff_datetime::DATE<to_date('2019-11-01','yyyy-mm-dd')

--3. 
select count(index) from green_taxi_data 
where trip_distance>3 and trip_distance<=7
and lpep_pickup_datetime::DATE>=to_date('2019-10-01','yyyy-mm-dd')
and lpep_pickup_datetime::DATE<to_date('2019-11-01','yyyy-mm-dd')
and lpep_dropoff_datetime::DATE<to_date('2019-11-01','yyyy-mm-dd')


--4.

select count(index) from green_taxi_data 
where trip_distance>7 and trip_distance<=10
and lpep_pickup_datetime::DATE>=to_date('2019-10-01','yyyy-mm-dd')
and lpep_pickup_datetime::DATE<to_date('2019-11-01','yyyy-mm-dd')
and lpep_dropoff_datetime::DATE<to_date('2019-11-01','yyyy-mm-dd')

--5

select count(index) from green_taxi_data 
where trip_distance>10
and lpep_pickup_datetime::DATE>=to_date('2019-10-01','yyyy-mm-dd')
and lpep_pickup_datetime::DATE<to_date('2019-11-01','yyyy-mm-dd')
and lpep_dropoff_datetime::DATE<to_date('2019-11-01','yyyy-mm-dd')



Question 4. Longest trip for each day


select lpep_pickup_datetime::DATE as pickup_date
from green_taxi_data
where trip_distance=(select max(trip_distance) from green_taxi_data);

Question 5. Three biggest pickup zones

with top_locns as(
select zone,
sum(total_amount),
dense_rank() over(order by sum(total_amount) desc) as top_pick
from green_taxi_data join zone
on green_taxi_data."PULocationID"=zone."LocationID"
where lpep_pickup_datetime::DATE=to_date('2019-10-18','yyyy-mm-dd')
group by zone
having(sum(total_amount))>13000
)
select * from top_locns where top_pick<=3


Question 6. Largest tip

with tips as(
select first_value(dropoff_zone."Zone") over(order by tip_amount desc),
tip_amount
from green_taxi_data join zone as pickup_zone
on green_taxi_data."PULocationID"=pickup_zone."LocationID"
join zone as dropoff_zone
on green_taxi_data."DOLocationID"=dropoff_zone."LocationID"
where EXTRACT(MONTH FROM lpep_pickup_datetime)=10
and EXTRACT(year FROM lpep_pickup_datetime)=2019
and pickup_zone."Zone"='East Harlem North'
)

select *
from tips




