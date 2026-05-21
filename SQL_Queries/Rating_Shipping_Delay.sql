SELECT        Shipping_Delay AS ShippingDelay, ROUND(AVG(CAST(Rating AS float)), 2) AS RatingAverage, SUM(CASE order_status WHEN 'Cancelled' THEN 1 ELSE 0 END) AS CancelledOrders
FROM            dbo.sales_data
GROUP BY Shipping_Delay