create database Projectdb;
use projectdb;
select * from maindata limit 10;
select count(*) from maindata;



create view order_date as select concat(year,"-",month,"-", day) as order_date,
Transported_Passengers,
available_seats,
from_to_city,
carrier_name,
distance_group_id from maindata;



select * from order_date limit 10;



create view kpi1 as select year(order_date) as year_number , 
month(order_date) as month_number,
day(order_date) as day_number, 
monthname(order_date) as month_name, 
concat("Q",quarter(order_date)) as quarter_number,
concat(year(order_date),'-',monthname(order_date)) as year_month_number,
weekday(order_date) as weekday_number,
dayname(order_date) as day_name,
case 
when quarter(order_date)=1 then "FQ4"
when quarter(order_date)=2 then "FQ1"
when quarter(order_date)=3 then "FQ2"
when quarter(order_date)=4 then "FQ3"
end as Financial_Quarter,
case
when month(order_date) = 1 then "10"
when month(order_date) = 2 then "11"
when month(order_date) = 3 then "12"
when month(order_date) = 4 then "1"
when month(order_date) = 5 then "2"
when month(order_date) = 6 then "3"
when month(order_date) = 7 then "4"
when month(order_date) = 8 then "5"
when month(order_date) = 9 then "6"
when month(order_date) = 10 then "7"
when month(order_date) = 11 then "8"
when month(order_date) = 12 then "9"
end as Financial_month,
case
when weekday(order_date) in (5,6) then "Weekend"
when weekday(order_date) in (0,1,2,3,4) then "Weekday"
end as weekend_weekday,
Transported_Passengers,
available_seats,
from_to_city,
carrier_name,
distance_group_id
from  order_date;




select * from kpi1 ;



select year_number,sum(transported_passengers),sum(available_seats), 
(sum(transported_passengers)/sum(available_seats)*100) 
as "load_Factor" from kpi1 group by year_number;



select quarter_number,sum(transported_passengers),sum(available_seats), 
(sum(transported_passengers)/sum(available_seats)*100) 
as "load_Factor" from kpi1 group by quarter_number order by quarter_number;



select month_name,sum(transported_passengers),sum(available_seats), 
(sum(transported_passengers)/sum(available_seats)*100) 
as "load_Factor" from kpi1 group by month_name;



select carrier_name,sum(transported_passengers),sum(available_seats), 
(sum(transported_passengers)/sum(available_seats)*100) 
as "load_Factor" from kpi1 group by carrier_name;



select carrier_name,sum(transported_passengers)
from kpi1 group by carrier_name order by sum(transported_passengers) desc limit 10;



select from_to_city, count(from_to_city) from kpi1 
group by from_to_city order by count(from_to_city) desc limit 10;



select weekend_weekday,sum(transported_passengers),sum(available_seats), 
(sum(transported_passengers)/sum(available_seats)*100) 
as "load_Factor" from kpi1 group by weekend_weekday;



select k.distance_group_id, d.distance_interval, count(from_to_city),d.group_id from 
kpi1 as k inner join distance_groups as d 
on k.distance_group_id = d.group_id group by distance_group_id;



select distance_group_id,  count(from_to_city), distance_interval from 
kpi1 group by distance_group_id;

set sql_safe_updates = 0;
set sql_mode = '';

select m.Distance_Group_ID, count(from_to_city), D.Distance_interval from 
KPI1 as m inner join Distance_Groups as D on m.Distance_Group_ID = D.Group_ID group by Distance_Group_ID;

select * from distance_groups;
