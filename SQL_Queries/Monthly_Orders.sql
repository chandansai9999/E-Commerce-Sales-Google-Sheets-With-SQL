SELECT        TOP (100) PERCENT DATENAME(MONTH, Order_Date) AS Month, COUNT(*) AS OrderCount, SUM(CASE order_status WHEN 'cancelled' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS CancellationRate
FROM            dbo.sales_data
GROUP BY DATENAME(MONTH, Order_Date), MONTH(Order_Date)
ORDER BY MONTH(Order_Date)