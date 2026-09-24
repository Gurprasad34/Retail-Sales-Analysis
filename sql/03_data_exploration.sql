-- Count the total number of transactions
SELECT COUNT(*) AS total_transactions
FROM retail_sales;

-- Count the number of unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales;

-- Select the earliest and latest transaction dates
SELECT
    MIN(transaction_date) AS first_transaction_date,
    MAX(transaction_date) AS last_transaction_date
FROM retail_sales;

-- Count transactions by product category
SELECT
    category,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category
ORDER BY total_transactions DESC;

-- Count transactions by product/item
SELECT
    item,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY item
ORDER BY total_transactions DESC;

-- Count transactions by payment method
SELECT
    payment_method,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY payment_method
ORDER BY total_transactions DESC;

-- Compare transaction counts by purchase location
SELECT
    location,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY location
ORDER BY total_transactions DESC;

-- Calculate the percentage of transactions by purchase location
SELECT
    location,
    COUNT(*) AS total_transactions,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM retail_sales),
        2
    ) AS percentage
FROM retail_sales
GROUP BY location
ORDER BY total_transactions DESC;

-- Explore the distribution of transaction sales amounts
SELECT
    MIN(total_spent) AS minimum_sale,
    MAX(total_spent) AS maximum_sale,
    ROUND(AVG(total_spent), 2) AS average_sale,
    SUM(total_spent) AS total_revenue
FROM retail_sales;

-- Group transactions into spending ranges
SELECT
    CASE
        WHEN total_spent < 50 THEN 'Under $50'
        WHEN total_spent < 100 THEN '$50 - $99.99'
        WHEN total_spent < 250 THEN '$100 - $249.99'
        WHEN total_spent < 500 THEN '$250 - $499.99'
        ELSE '$500+'
    END AS spending_range,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY spending_range
ORDER BY MIN(total_spent);

-- Analyze the distribution of quantities purchased per transaction
SELECT
    quantity,
    COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY quantity
ORDER BY quantity;
