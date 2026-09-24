USE retail_sales_analysis;

-- Preview data
SELECT *
FROM retail_sales
LIMIT 10;

-- Inspec the columns and data types
DESCRIBE retail_sales;
-- Finding: Transaction Date needs to be converted to do DATE from text

-- Count number of rows in data
SELECT 
    COUNT(*) AS total_rows
FROM retail_sales;

-- Check all unique products
SELECT
    DISTINCT Category
FROM retail_sales
ORDER BY Category;

-- Check all unique payment methofs
SELECT 
    DISTINCT `Payment Method`
FROM retail_sales
ORDER BY `Payment Method`;

-- Check all unique location
SELECT 
    DISTINCT Location
FROM retail_sales
ORDER BY Location;

-- Check all unique discount values
SELECT 
    DISTINCT `Discount Applied`
FROM retail_sales
ORDER BY `Discount Applied`;

-- Count all the null values for each column
SELECT
    SUM(`Transaction ID` IS NULL) AS transaction_id_nulls,
    SUM(`Customer ID` IS NULL) AS customer_id_nulls,
    SUM(Category IS NULL) AS category_nulls,
    SUM(Item IS NULL) AS item_nulls,
    SUM(`Price Per Unit` IS NULL) AS price_per_unit_nulls,
    SUM(Quantity IS NULL) AS quantity_nulls,
    SUM(`Total Spent` IS NULL) AS total_spent_nulls,
    SUM(`Payment Method` IS NULL) AS payment_method_nulls,
    SUM(Location IS NULL) AS location_nulls,
    SUM(`Transaction Date` IS NULL) AS transaction_date_nulls,
    SUM(`Discount Applied` IS NULL) AS discount_applied_nulls
FROM retail_sales;

-- Count number of blank/whitespacs in text columns
SELECT
    SUM(TRIM(`Transaction ID`) = '') AS transaction_id_blanks,
    SUM(TRIM(`Customer ID`) = '') AS customer_id_blanks,
    SUM(TRIM(Category) = '') AS category_blanks,
    SUM(TRIM(Item) = '') AS item_blanks,
    SUM(TRIM(`Payment Method`) = '') AS payment_method_blanks,
    SUM(TRIM(Location) = '') AS location_blanks,
    SUM(TRIM(`Transaction Date`) = '') AS transaction_date_blanks,
    SUM(TRIM(`Discount Applied`) = '') AS discount_applied_blanks
FROM retail_sales;
-- -- Finding: Discount Applied contains 3,783 blank values.


-- Check for duplicate Transaction IDs
SELECT
    `Transaction ID`,
    COUNT(*) AS occurrence_count
FROM retail_sales
GROUP BY `Transaction ID`
HAVING COUNT(*) > 1
ORDER BY occurrence_count DESC;

-- Check for completely duplicate rows
SELECT
    `Transaction ID`,
    `Customer ID`,
    Category,
    Item,
    `Price Per Unit`,
    Quantity,
    `Total Spent`,
    `Payment Method`,
    Location,
    `Transaction Date`,
    `Discount Applied`,
    COUNT(*) AS occurrence_count
FROM retail_sales
GROUP BY
    `Transaction ID`,
    `Customer ID`,
    Category,
    Item,
    `Price Per Unit`,
    Quantity,
    `Total Spent`,
    `Payment Method`,
    Location,
    `Transaction Date`,
    `Discount Applied`
HAVING COUNT(*) > 1;

-- Inspect sample transaction date value to make sure theya re the same format
SELECT `Transaction Date`
FROM retail_sales
LIMIT 20;

-- Check the transaction date range
-- YYYY-MM-DD sorts correctly even as text so MIN() and MAX() will gives us the correct range
SELECT
    MIN(`Transaction Date`) AS earliest_date,
    MAX(`Transaction Date`) AS latest_date
FROM retail_sales;

-- Inspect the ranges and averages of all our numeric columns
SELECT
    MIN(`Price Per Unit`) AS min_price,
    MAX(`Price Per Unit`) AS max_price,
    AVG(`Price Per Unit`) AS avg_price,

    MIN(Quantity) AS min_quantity,
    MAX(Quantity) AS max_quantity,
    AVG(Quantity) AS avg_quantity,

    MIN(`Total Spent`) AS min_total_spent,
    MAX(`Total Spent`) AS max_total_spent,
    AVG(`Total Spent`) AS avg_total_spent
FROM retail_sales;

-- Check whether Total Spent matches Price Per Unit × Quantity for all transactions
SELECT
    `Transaction ID`,
    `Price Per Unit`,
    Quantity,
    `Total Spent`,
    (`Price Per Unit` * Quantity) AS expected_total
FROM retail_sales
WHERE ABS(
    `Total Spent` - (`Price Per Unit` * Quantity)
) > 0.01;

