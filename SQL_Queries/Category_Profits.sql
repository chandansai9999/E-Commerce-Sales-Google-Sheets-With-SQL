SELECT        Category, ROUND(SUM(Profit), 2) AS CategoryProfit
FROM            dbo.sales_data
WHERE        (Order_status = 'Delivered') AND (Returned = 'No')
GROUP BY Category