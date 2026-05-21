SELECT        City, ROUND(SUM(Revenue), 2) AS CityRevenue, SUM(Profit) / SUM(Revenue) AS ProfitMargin
FROM            dbo.sales_data
WHERE        (Order_status = 'Delivered') AND (Returned = 'No')
GROUP BY City