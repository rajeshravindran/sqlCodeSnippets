--/
--THIS SQL SNIPPET HELPS IN IDENTIFYING IF THE DATES ARE FALLING ON 3 CONSECUTIVE DATES
--THE SQL IS WRITTEN AND EXECUTED IN MYSQL
--TO TEST THE SQL FOLLOWING TABLE IS USED
--CUSTOMER_PURCHASE(CUSTOMERID INT, CUSTOMERNAME VARCHAR, PURCHASEDATE DATE)
--LOGIC CAN BE EXTENDED TO ANY TIMELINE WITH MINIMAL CHANGES
--/

SELECT   customerid, 
         customername, 
         Min(purchasedate)    purchasedate_min, 
         Max(purchasedate)    purchasedate_max, 
         Count(*)          AS consecutive_days 
FROM     ( 
                  SELECT   customerid, 
                           customername, 
                           purchasedate, 
                           date_add(purchasedate, interval -Row_number()OVER(ORDER BY purchasedate) day) AS groupingset 
                  FROM     customer_purchase)a 
GROUP BY customerid, 
         customername, 
         groupingset 
HAVING   count(*)>=3;


