SELECT        SUM(CASE returned WHEN 'Yes' THEN 1 ELSE 0 END) * 1.0 / COUNT(*) AS ReturnRate
FROM            dbo.sales_data
WHERE        (Order_status = 'Delivered')