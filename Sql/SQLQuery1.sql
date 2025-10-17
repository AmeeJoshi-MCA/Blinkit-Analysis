select * from BlinkIT_Data

-- Clean data 
-- 1 Update Item_fat_content values symmetic 

Update BlinkIT_Data
set Item_Fat_Content = 
Case 
	when Item_Fat_content In ('low Fat', 'LF') then 'Low Fat'
	when Item_Fat_content = 'reg' then 'Regular'
	else Item_Fat_content
End;

select Item_Fat_content from BlinkIT_Data group by Item_Fat_content


------------------------------------------  A :- KPIS -------------------------------------------------
-- 1 Total Sales

select cast (sum(Total_Sales)/1000000 as decimal(10,2)) as Total_sale_in_millions from BlinkIT_Data 

----2 Average sales 

select cast (AVG(Total_Sales) as int) from BlinkIT_Data

-----3 No of items

select COUNT(*) as No_Of_Items from BlinkIT_Data

-----4 Average rating 

select cast(AVG(Rating) as decimal(10,1))  as Average_rating from BlinkIT_Data

------------------------------------------  B :- Total sale by Fat Content -------------------------------------------------

select Item_Fat_Content,cast (sum(Total_Sales)as decimal(10,2)) from BlinkIT_Data group by Item_Fat_Content

------------------------------------------  C :- Total sale by Item type -------------------------------------------------


select Item_Type,cast (sum(Total_Sales)as decimal(10,2)) as Total_Sale from BlinkIT_Data group by Item_Type
 order by Total_Sale Desc

 
 ------------------------------------------  D :- Fat Content by outlet for total sale -------------------------------------------------


SELECT 
    Outlet_Location_Type,
    
    -- Total sales for Low Fat items
    SUM(CASE WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales ELSE 0 END) AS Low_Fat,
    
    -- Total sales for Regular items
    SUM(CASE WHEN Item_Fat_Content = 'Regular' THEN Total_Sales ELSE 0 END) AS Regular

FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;


------------------------------------------  E :- Total sale by outlet establishment -------------------------------------------------

select Outlet_Establishment_Year,CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
from BlinkIT_Data 
group by Outlet_Establishment_Year
order by Outlet_Establishment_Year Desc


------------------------------------------  F :- Percentage of sale by outlet size -------------------------------------------------

select Outlet_Size ,CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales  ,
ROUND(
        (SUM(Total_Sales) * 100.0) / 
        (SELECT SUM(Total_Sales) FROM blinkit_data), 2
    ) AS Percentage_of_Total
from BlinkIT_Data
group by Outlet_Size
order by Outlet_Size Desc


------------------------------------------  G :- Sale by outlet Location -------------------------------------------------

SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC


------------------------------------------  H :- All metrix by outlet by outlet -------------------------------------------------

SELECT Outlet_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC




