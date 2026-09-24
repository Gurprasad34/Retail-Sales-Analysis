-- Create a backup of the raw data before cleaning since we our altering our table
CREATE TABLE retail_sales_backup AS
SELECT *
FROM retail_sales;

-- Check it see if our backup has the same number of rows
    (SELECT COUNT(*) FROM retail_sales) AS original_rows,
    (SELECT COUNT(*) FROM retail_sales_backup) AS backup_rows;

-- Standardize column names using snake_case
ALTER TABLE retail_sales
RENAME COLUMN `Transaction ID` TO transaction_id,
RENAME COLUMN `Customer ID` TO customer_id,
RENAME COLUMN `Category` TO category,
RENAME COLUMN `Item` TO item,
RENAME COLUMN `Price Per Unit` TO price_per_unit,
RENAME COLUMN `Quantity` TO quantity,
RENAME COLUMN `Total Spent` TO total_spent,
RENAME COLUMN `Payment Method` TO payment_method,
RENAME COLUMN `Location` TO location,
RENAME COLUMN `Transaction Date` TO transaction_date,
RENAME COLUMN `Discount Applied` TO discount_applied;

-- Check that all columsn were renamed
DESCRIBE retail_sales;

-- Inspect discount_applied values and how many times they occir
SELECT
    discount_applied,
    COUNT(*) AS record_count
FROM retail_sales
GROUP BY discount_applied
ORDER BY record_count DESC;

-- Inspect recorowsrds with a blank discount_applied value
SELECT *
FROM retail_sales
WHERE TRIM(discount_applied) = ''
LIMIT 20;

-- Convert blank discount values to NULL
UPDATE retail_sales
SET discount_applied = NULL
WHERE TRIM(discount_applied) = '';

-- Confirm discount_applied values after cleaning
SELECT
    discount_applied,
    COUNT(*) AS record_count
FROM retail_sales
GROUP BY discount_applied
ORDER BY record_count DESC;

-- Convert transaction_date from TEXT to DATE
ALTER TABLE retail_sales
MODIFY COLUMN transaction_date DATE;

-- Check transaction_dates data type
DESCRIBE retail_sales;

-- Check for quantities containing decimal values
SELECT *
FROM retail_sales
WHERE quantity <> FLOOR(quantity);

-- Convert quantity from DOUBLE to INT since all values are whole numbers
ALTER TABLE retail_sales
MODIFY COLUMN quantity INT;

SELECT *
FROM retail_sales
WHERE ROUND(price_per_unit, 2) <> price_per_unit
   OR ROUND(total_spent, 2) <> total_spent;

-- Convert monetary columns from DOUBLE to DECIMAL for exact precision
-- Since DOUBLE can have tiny precision errors, while DECIMAL stores exact decimal values
ALTER TABLE retail_sales
MODIFY COLUMN price_per_unit DECIMAL(10,2),
MODIFY COLUMN total_spent DECIMAL(10,2);


