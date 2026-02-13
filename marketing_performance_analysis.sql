create database Marketing_Performance_Analytics;
create table campigns (campaign_id int primary key,campaign_name varchar(255),ad_spend decimal(10,2),clicks int,impressions int,conversions int);
INSERT INTO campigns VALUES
(1, 'Google_Search', 5000, 1000, 20000, 50),
(2, 'Facebook_Ads', 3000, 800, 15000, 40),
(3, 'Instagram_Ads', 2000, 500, 10000, 25);

select* from campigns;

create table customers (customer_id int primary key,campaign_id int,revenue decimal(10,2),purchase_date date);
INSERT INTO customers VALUES
(1, 1, 2000, '2025-01-10'),
(2, 1, 1500, '2025-01-11'),
(3, 2, 1800, '2025-01-12'),
(4, 2, 1200, '2025-01-15'),
(5, 3, 1000, '2025-01-18');

select* from customers;


-- cpc (cost per click)
select campaign_name,ad_spend/clicks as CPC from campigns;

-- conversion rate
select campaign_name,(impressions/clicks)*100 as conversion_rate from campigns;

-- ROAS(return on ad spend)
select campaign_name,revenue/ad_spend as ROAS 
from campigns  c 
join customers cs on cs.campaign_id = c.campaign_id
group by c.campaign_name,ROAS; 

-- cac (customer acquisition cost)
select campaign_name,c.ad_spend/count(c.campaign_id) as CAC
from campigns c
join customers cs on cs.campaign_id = c.campaign_id
group by c.campaign_id;

-- total revenue per campaign
select campaign_name,sum(cs.revenue) as Total_revenue
from campigns c
join customers cs on cs.campaign_id = c.campaign_id
group  by campaign_name;


SELECT 
    c.campaign_name,
    c.ad_spend,
    SUM(cs.revenue) AS total_revenue,
    COUNT(cs.customer_id) AS customers_acquired,
    (c.ad_spend / COUNT(cs.customer_id)) AS CAC,
    (SUM(cs.revenue) / c.ad_spend) AS ROAS,
    (c.conversions / c.clicks) * 100 AS conversion_rate
FROM campaigns c
JOIN customers cs 
ON c.campaign_id = cs.campaign_id
GROUP BY c.campaign_name, c.ad_spend, c.conversions, c.clicks;






