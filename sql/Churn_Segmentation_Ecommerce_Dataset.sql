-- Investigating Discount --
SELECT
    CASE
        WHEN discount_usage_rate < 25 THEN '<25%'
        WHEN discount_usage_rate < 50 THEN '25-50%'
        WHEN discount_usage_rate < 75 THEN '50-75%'
        ELSE '75%+'
    END AS discount_group,
    COUNT(*) AS customers,
    SUM(churned) AS churned_customers,
    ROUND(100.0 * SUM(churned) / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_churn
GROUP BY 1
ORDER BY 1;

-- Investigating Login Frequency vs Churn --
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
GROUP BY 1
ORDER BY 1;

-- Analyzing membership Tenure --
SELECT
    CASE
        WHEN membership_years < 1 THEN '<1 year'
        WHEN membership_years < 3 THEN '1-3 years'
        WHEN membership_years < 5 THEN '3-5 years'
        ELSE '5+ years'
    END AS membership_group,
    COUNT(*) AS customers,
    SUM(churned) AS churned_customers,
    ROUND(100.0 * SUM(churned) / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_churn
GROUP BY 1
ORDER BY 1;

-- Analyzing Email Engagement --
SELECT
    CASE
        WHEN email_open_rate < 25 THEN '<25%'
        WHEN email_open_rate < 50 THEN '25-50%'
        WHEN email_open_rate < 75 THEN '50-75%'
        ELSE '75%+'
    END AS email_group,
    COUNT(*) AS customers,
    SUM(churned) AS churned_customers,
    ROUND(100.0 * SUM(churned) / COUNT(*), 2) AS churn_rate
FROM ecommerce_customer_churn
GROUP BY 1
ORDER BY 1;

-- Analyzing Session Duration --
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

