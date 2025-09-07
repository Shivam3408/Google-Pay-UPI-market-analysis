CREATE TABLE upi(
			app_name	TEXT,
			customer_transactions_volume	NUMERIC,
			customer_transactions_value	NUMERIC,
			b2c_volume	NUMERIC,
			b2c_value	NUMERIC,
			b2b_volume	NUMERIC,
			b2b_value	NUMERIC,
			on_us_volume	NUMERIC,
			on_us_value	NUMERIC,
			total_volume	NUMERIC,
			total_value	NUMERIC,
			months	DATE
);

SELECT * FROM upi

SELECT DISTINCT(app_name), customer_transactions_volume
FROM upi 
ORDER BY customer_transactions_volume DESC
LIMIT 10;
/* This query returns the top 10 most volume transactions by app, this represents that phonepe 
   is dominating the market with lots of users */
   

SELECT app_name, SUM(customer_transactions_volume) total_volume_millions
FROM upi
GROUP BY app_name
ORDER BY total_volume_millions DESC;
/*This query returns the SUM of all the transaction occurred in different month of the year,
  the top 2 upi apps that has processed the most transactions are Phonepe & Google Pay*/


SELECT app_name, SUM(customer_transactions_value) total_value_crore
FROM upi
GROUP BY app_name
ORDER BY total_value_crore DESC;
/* In this query result we can conclude that the volume of transaction of Amazon pay iis more than cred 
   but the Sum value of Cred transactions are more than Amazon Pay*/


SELECT TO_CHAR(DATE_TRUNC('month', months), 'Mon YYYY') AS months_year, app_name, 
SUM(customer_transactions_volume) AS total_volume,
SUM(customer_transactions_value) AS total_value
FROM upi
GROUP BY DATE_TRUNC('month', months), app_name
ORDER BY DATE_TRUNC('month', months), total_value DESC;
/* Monthly upi transaction analysis: 
  - Groups transaction by month in (Mon yyyy) format and app_name
  - Calculates total volume and value by Month and orders result on chronological order*/


SELECT app_name, 
		SUM(customer_transactions_volume) AS total_volume,
		SUM(customer_transactions_value) AS total_value,
		SUM(customer_transactions_value) * 100/
		SUM(SUM(customer_transactions_value)) OVER() AS market_share
FROM upi
GROUP BY app_name
ORDER BY total_value DESC; 
/* Market share of apps acccording to the transaction value
  - PhonePe is dominating the UPI market with 49.506%
  - Whereas Google at second place holds 35.003% of market share*/ 
   

SELECT app_name, SUM(total_value)/SUM(total_volume) AS value_to_volume_ratio
FROM upi
GROUP BY app_name
ORDER BY volume_to_value_ratio DESC;
/* This query calculates the Average Ticket Size(ATS) = Total value / Total volume
	- GooglePay ratio is 173 because they are widely used even for smaller transactions*/
	

SELECT 
SUM(CASE WHEN app_name IN('Google Pay', 'PhonePe') THEN total_value ELSE 0 END)*100
/SUM(total_value) AS top2_share_percent
FROM upi
/* There is a duopoly in the market between Google Pay and PhonePe both the app are widely
	used and holding 80%+ market share*/

 

 
 



