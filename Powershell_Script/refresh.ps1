# ====== CONFIGURATION ======
$csvUrl = "https://docs.google.com/spreadsheets/d/1Wi7Es3IdUgZKavqp7EaQkoNxh3iVPg_-yenPPGQNAeM/export?format=csv"
$csvPath = "C:\sql_refresh\sales_data.csv"

$server = "DESKTOP-H59UKVR\SQLEXPRESS"
$database = "EcommerceDB"
$table = "sales_data"
$username = "chandan"
$password = "C#@nd114"

# ====== STEP 1: DOWNLOAD CSV ======
Write-Host "Downloading latest data from Google Sheets..."

Invoke-WebRequest -Uri $csvUrl -OutFile $csvPath

Write-Host "Download completed."

# ====== STEP 2: CONNECT TO SQL & REPLACE DATA ======

# Clear existing data
$truncateQuery = "TRUNCATE TABLE $table"

# Bulk insert query
$bulkInsertQuery = @"
BULK INSERT $table
FROM '$csvPath'
WITH (
    FORMAT='CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);
"@

Write-Host "Updating SQL table..."

# Run queries
sqlcmd -S $server -d $database -U $username -P $password -Q $truncateQuery -C
sqlcmd -S $server -d $database -U $username -P $password -Q $bulkInsertQuery -C

Write-Host "SQL table updated successfully!"

# ====== DONE ======
Write-Host "Data refresh completed!"

Write-Host "Exporting SQL views..."

sqlcmd -S $server -d $database -U $username -P $password -Q "SET NOCOUNT ON; SELECT * FROM City_wise_revenue_profit order by CityRevenue" -o "C:\Users\india\Downloads\GoogleSheets\city_revenue.csv" -s "," -W -C

sqlcmd -S $server -d $database -U $username -P $password -Q "SET NOCOUNT ON; SELECT * FROM Category_Wise_Profits" -o "C:\Users\india\Downloads\GoogleSheets\category_profits.csv" -s "," -W -C

sqlcmd -S $server -d $database -U $username -P $password -Q "SET NOCOUNT ON; SELECT * FROM Monthly_Order_Trends" -o "C:\Users\india\Downloads\GoogleSheets\Monthly_trend.csv" -s "," -W -C

sqlcmd -S $server -d $database -U $username -P $password -Q "SET NOCOUNT ON; SELECT * FROM Avg_Rating_Shipping_Delay order by ShippingDelay" -o "C:\Users\india\Downloads\GoogleSheets\Avg_rating_shipping_delay.csv" -s "," -W -C

sqlcmd -S $server -d $database -U $username -P $password -Q "SET NOCOUNT ON; SELECT * FROM Return_rate" -o "C:\Users\india\Downloads\GoogleSheets\Return_rate.csv" -s "," -W -C

Write-Host "Export completed!"