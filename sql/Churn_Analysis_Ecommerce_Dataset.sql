-- Lets Start with analyzing now --

-- Checking churn Rate --

SELECT
    COUNT(*) AS total_customers,
    SUM(churned) AS churned_customers,
    ROUND(100.0 * SUM(churned) / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_churn;


-- Churned vs Active Customers --
SELECT
    churned,
    COUNT(*) AS customers,
    ROUND(AVG(login_frequency), 2) AS avg_logins,
    ROUND(AVG(session_duration_avg), 2) AS avg_session_duration,
    ROUND(AVG(total_purchases), 2) AS avg_purchases,
    ROUND(AVG(average_order_value), 2) AS avg_order_value,
    ROUND(AVG(days_since_last_purchase), 2) AS avg_days_since_purchase,
    ROUND(AVG(lifetime_value), 2) AS avg_lifetime_value
FROM ecommerce_customer_churn
GROUP BY churned;

-- Finding Strongest Churn Drivers --
SELECT
    CASE
        WHEN login_frequency < 5 THEN '<5'
        WHEN login_frequency < 10 THEN '5-10'
        WHEN login_frequency < 15 THEN '10-15'
        ELSE '15+'
    END AS login_group,
    COUNT(*) AS customers,
    SUM(churned) AS churned_customers,
    ROUND(100.0 * SUM(churned) / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_churn
GROUP BY login_group
ORDER BY login_group;

-- Investigating Purchase Recency --
SELECT
    CASE
        WHEN days_since_last_purchase <= 15 THEN '0-15 days'
        WHEN days_since_last_purchase <= 30 THEN '16-30 days'
        WHEN days_since_last_purchase <= 60 THEN '31-60 days'
        ELSE '60+ days'
    END AS recency_group,
    COUNT(*) AS customers,
    SUM(churned) AS churned_customers,
    ROUND(100.0 * SUM(churned) / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_churn
GROUP BY 1
ORDER BY 1;

-- Investigating Cart Abandonment --
SELECT
    CASE
        WHEN cart_abandonment_rate < 25 THEN '<25%'
        WHEN cart_abandonment_rate < 50 THEN '25-50%'
        WHEN cart_abandonment_rate < 75 THEN '50-75%'
        ELSE '75%+'
    END AS abandonment_group,
    COUNT(*) AS customers,
    SUM(churned) AS churned_customers,
    ROUND(100.0 * SUM(churned) / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_churn
GROUP BY 1
ORDER BY 1;

--Investigating Session Engagement -- 
SELECT
    CASE
        WHEN session_duration_avg < 15 THEN '<15 min'
        WHEN session_duration_avg < 25 THEN '15-25 min'
        WHEN session_duration_avg < 35 THEN '25-35 min'
        ELSE '35+ min'
    END AS session_group,
    COUNT(*) AS customers,
    SUM(churned) AS churned_customers,
    ROUND(100.0 * SUM(churned) / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_churn
GROUP BY 1
ORDER BY 1;

-- Investigating Purchase Frequency --
SELECT
    CASE
        WHEN total_purchases < 5 THEN '<5'
        WHEN total_purchases < 10 THEN '5-10'
        WHEN total_purchases < 20 THEN '10-20'
        ELSE '20+'
    END AS purchase_group,
    COUNT(*) AS customers,
    SUM(churned) AS churned_customers,
    ROUND(100.0 * SUM(churned) / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_churn
GROUP BY 1
ORDER BY 1;

-- Investigating AOV --
SELECT
    CASE
        WHEN average_order_value < 75 THEN '<75'
        WHEN average_order_value < 100 THEN '75-100'
        WHEN average_order_value < 125 THEN '100-125'
        WHEN average_order_value < 150 THEN '125-150'
        ELSE '150+'
    END AS aov_group,
    COUNT(*) AS customers,
    SUM(churned) AS churned_customers,
    ROUND(100.0 * SUM(churned) / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_churn
GROUP BY 1
ORDER BY 1;

