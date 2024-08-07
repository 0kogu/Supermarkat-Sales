SELECT * 
FROM supermarket_sales;

ALTER TABLE supermarket_sales
RENAME COLUMN Date TO date_transaction;

#-------Alter "date_transaction" column to date type
ALTER TABLE supermarket_sales
MODIFY date_transaction DATE;



#-------CALCULATE TOTAL REVENUE ---------------------------------------------------------------
SELECT 
    ROUND(SUM(Total),2) AS Total_Revenue
FROM 
    supermarket_sales;


#-----CALCULATE TOTAL PROFIT----------------------------------------------------------
SELECT 
    ROUND(SUM(gross_income),2) AS Total_Profit
FROM 
    supermarket_sales;
    
    
#----TOTAL PROFIT MARGIN ------------------------------------------------------
SELECT 
    ROUND((SUM(gross_income) / SUM(Total)) * 100,2) AS Total_Profit_Margin_Percentage
FROM 
    supermarket_sales;
    

    
#------AVERAGE TRANSACTION-----------------------
SELECT
	ROUND(AVG(Total),2) As Average_Transaction
FROM 
    supermarket_sales;

#----MONTHLY SALES---------------------------------------------------------------
SELECT 
    MONTHNAME(STR_TO_DATE(date_transaction, '%m/%d/%Y')) AS month_name,
    ROUND(SUM(Total),2) AS Total_Revenue
FROM 
    supermarket_sales
GROUP BY 
	month_name
ORDER BY
	MONTHNAME(STR_TO_DATE(date_transaction, '%m/%d/%Y'));



#--------REVENUE BY city-------------------------------------
SELECT 
    City, 
    ROUND(SUM(Total),2) AS Total_Revenue
FROM 
    supermarket_sales
GROUP BY 
    City
ORDER BY
	Total_Revenue DESC;



#---------Revenue by Product Line--------------------------------------
SELECT 
    Product_line, 
    ROUND(SUM(Total),2) AS Total_Revenue
FROM 
    supermarket_sales
GROUP BY 
    Product_line
ORDER BY 
    Total_Revenue DESC;

#-----Most Consumed Product Line By Gender--------
SELECT 
    Gender,
    Product_line,
    Total_Quantity
FROM (
    SELECT 
        Gender,
        Product_line,
        SUM(Quantity) AS Total_Quantity,
        ROW_NUMBER() OVER (PARTITION BY Gender ORDER BY SUM(Quantity) DESC) AS row_num
    FROM 
        supermarket_sales
    GROUP BY 
        Gender, Product_line
) AS subquery
WHERE 
    row_num = 1;



#--------------Revenue by customer type----------
SELECT 
    Customer_type, 
	ROUND(SUM(Total),2) AS Total_Revenue
FROM 
    supermarket_sales
GROUP BY 
    Customer_type;
    
    


#---------Revenue for each payment method.------------------------------------
SELECT 
    Payment, 
    ROUND(SUM(Total),2) AS Total_Revenue
FROM 
    supermarket_sales
GROUP BY 
    Payment
ORDER BY
	Total_Revenue DESC;


    
#----------Revenue by gender.------------------
SELECT 
    Gender, 
    ROUND(SUM(Total),2) AS Total_Revenue
FROM 
    supermarket_sales
GROUP BY 
    Gender;

#---------REVENUE BY DAY OF THE WEEK----------------------------------
SELECT
	DAYNAME(STR_TO_DATE(date_transaction,'%m/%d/%Y')) AS day_name,
	ROUND(SUM(Total),2) AS Total_Revenue
FROM 
    supermarket_sales
GROUP BY
	day_name
ORDER BY 
	Total_Revenue DESC;
    
   
   
   
   
   
    