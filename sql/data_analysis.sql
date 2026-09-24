-- Calculate core business KPIs:
-- total revenue, total transactions, and average order value
SELECT
    ROUND(SUM(total_spent), 2) AS total_revenue,
    COUNT(*) AS total_transactions,
    ROUND(AVG(total_spent), 2) AS average_order_value
FROM retail_sales;


-- Calculate total revenue by month
SELECT
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    ROUND(SUM(total_spent), 2) AS monthly_revenue
FROM retail_sales
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY month;


-- Calculate month-over-month revenue growth
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(transaction_date, '%Y-%m') AS month,
        SUM(total_spent) AS monthly_revenue
    FROM retail_sales
    GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
)

SELECT
    month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(
        LAG(monthly_revenue) OVER (ORDER BY month),
        2
    ) AS previous_month_revenue
FROM monthly_sales
ORDER BY month;


-- Calculate month-over-month revenue growth percentage
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(transaction_date, '%Y-%m') AS month,
        SUM(total_spent) AS monthly_revenue
    FROM retail_sales
    GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
),

monthly_comparison AS (
    SELECT
        month,
        monthly_revenue,
        LAG(monthly_revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_sales
)

SELECT
    month,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        ((monthly_revenue - previous_month_revenue)
        / previous_month_revenue) * 100,
        2
    ) AS mom_growth_percent
FROM monthly_comparison
ORDER BY month;


-- Calculate total revenue by product category
SELECT
    category,
    ROUND(SUM(total_spent), 2) AS total_revenue
FROM retail_sales
GROUP BY category
ORDER BY total_revenue DESC;


-- Calculate each category's share of total revenue
SELECT
    category,
    ROUND(SUM(total_spent), 2) AS total_revenue,
    ROUND(
        SUM(total_spent) * 100.0 /
        (SELECT SUM(total_spent) FROM retail_sales),
        2
    ) AS revenue_percentage
FROM retail_sales
GROUP BY category
ORDER BY total_revenue DESC;

-- Rank products by total revenue
WITH product_revenue AS (
    SELECT
        item,
        SUM(total_spent) AS total_revenue
    FROM retail_sales
    GROUP BY item
)

SELECT
    item,
    ROUND(total_revenue, 2) AS total_revenue,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM product_revenue
ORDER BY revenue_rank;

-- Identify the top 5 products by revenue
SELECT
    item,
    ROUND(SUM(total_spent), 2) AS total_revenue
FROM retail_sales
GROUP BY item
ORDER BY total_revenue DESC
LIMIT 5;


-- Identify the bottom 5 products by revenue
SELECT
    item,
    ROUND(SUM(total_spent), 2) AS total_revenue
FROM retail_sales
GROUP BY item
ORDER BY total_revenue ASC
LIMIT 5;


-- Compare sales performance by purchase location
SELECT
    location,
    COUNT(*) AS total_transactions,
    ROUND(SUM(total_spent), 2) AS total_revenue,
    ROUND(AVG(total_spent), 2) AS average_order_value
FROM retail_sales
GROUP BY location
ORDER BY total_revenue DESC;


-- Identify the top 10 customers by total spending
SELECT
    customer_id,
    COUNT(*) AS total_transactions,
    ROUND(SUM(total_spent), 2) AS total_spent,
    ROUND(AVG(total_spent), 2) AS average_order_value
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

-- Compare every different discount status
SELECT
    CASE
        WHEN discount_applied = 'True' THEN 'Discount Applied'
        WHEN discount_applied = 'False' THEN 'No Discount'
        ELSE 'Unknown'
    END AS discount_status,

    COUNT(*) AS total_transactions,
    ROUND(SUM(total_spent), 2) AS total_revenue,
    ROUND(AVG(total_spent), 2) AS average_order_value

FROM retail_sales

GROUP BY
    CASE
        WHEN discount_applied = 'True' THEN 'Discount Applied'
        WHEN discount_applied = 'False' THEN 'No Discount'
        ELSE 'Unknown'
    END

ORDER BY total_revenue DESC;


-- Cleaned transaction-level data for Excel analysis
SELECT
    transaction_id,
    customer_id,
    category,
    item,
    price_per_unit,
    quantity,
    total_spent,
    payment_method,
    location,
    transaction_date,
    discount_applied
FROM retail_sales
ORDER BY transaction_date;