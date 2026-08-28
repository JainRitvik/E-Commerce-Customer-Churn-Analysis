/* In this step we are going to clean the data */

-- checking row count --
SELECT COUNT(*)
FROM ecommerce_customer_churn;

-- getting a basic understanding of the data --
SELECT *
FROM ecommerce_customer_churn
LIMIT 10;

-- checking for any missing values --
SELECT
    COUNT(*) AS total_rows,
    COUNT(age) AS age_filled,
    COUNT(gender) AS gender_filled,
    COUNT(country) AS country_filled,
    COUNT(city) AS city_filled,
    COUNT(membership_years) AS membership_years_filled,
    COUNT(login_frequency) AS login_frequency_filled,
    COUNT(session_duration_avg) AS session_duration_filled,
    COUNT(pages_per_session) AS pages_per_session_filled,
    COUNT(cart_abandonment_rate) AS cart_abandonment_filled,
    COUNT(wishlist_items) AS wishlist_filled,
    COUNT(total_purchases) AS purchases_filled,
    COUNT(average_order_value) AS aov_filled,
    COUNT(days_since_last_purchase) AS last_purchase_filled,
    COUNT(discount_usage_rate) AS discount_usage_filled,
    COUNT(returns_rate) AS returns_filled,
    COUNT(email_open_rate) AS email_open_filled,
    COUNT(customer_service_calls) AS service_calls_filled,
    COUNT(product_reviews_written) AS reviews_filled,
    COUNT(social_media_engagement_score) AS social_engagement_filled,
    COUNT(mobile_app_usage) AS mobile_usage_filled,
    COUNT(payment_method_diversity) AS payment_diversity_filled,
    COUNT(lifetime_value) AS lifetime_value_filled,
    COUNT(credit_balance) AS credit_balance_filled,
    COUNT(churned) AS churned_filled,
    COUNT(signup_quarter) AS signup_quarter_filled
FROM ecommerce_customer_churn;

-- number of missing values --
SELECT
    COUNT(*) - COUNT(age) AS age_missing,
    COUNT(*) - COUNT(gender) AS gender_missing,
    COUNT(*) - COUNT(country) AS country_missing,
    COUNT(*) - COUNT(city) AS city_missing,
    COUNT(*) - COUNT(membership_years) AS membership_years_missing,
    COUNT(*) - COUNT(login_frequency) AS login_frequency_missing,
    COUNT(*) - COUNT(session_duration_avg) AS session_duration_missing,
    COUNT(*) - COUNT(pages_per_session) AS pages_per_session_missing,
    COUNT(*) - COUNT(cart_abandonment_rate) AS cart_abandonment_missing,
    COUNT(*) - COUNT(wishlist_items) AS wishlist_missing,
    COUNT(*) - COUNT(total_purchases) AS purchases_missing,
    COUNT(*) - COUNT(average_order_value) AS aov_missing,
    COUNT(*) - COUNT(days_since_last_purchase) AS last_purchase_missing,
    COUNT(*) - COUNT(discount_usage_rate) AS discount_usage_missing,
    COUNT(*) - COUNT(returns_rate) AS returns_missing,
    COUNT(*) - COUNT(email_open_rate) AS email_open_missing,
    COUNT(*) - COUNT(customer_service_calls) AS service_calls_missing,
    COUNT(*) - COUNT(product_reviews_written) AS reviews_missing,
    COUNT(*) - COUNT(social_media_engagement_score) AS social_engagement_missing,
    COUNT(*) - COUNT(mobile_app_usage) AS mobile_usage_missing,
    COUNT(*) - COUNT(payment_method_diversity) AS payment_diversity_missing,
    COUNT(*) - COUNT(lifetime_value) AS lifetime_value_missing,
    COUNT(*) - COUNT(credit_balance) AS credit_balance_missing,
    COUNT(*) - COUNT(churned) AS churned_missing,
    COUNT(*) - COUNT(signup_quarter) AS signup_quarter_missing
FROM ecommerce_customer_churn;

-- Fixing the numerical missing values with median --
-- Median is safer when the dataset is skewed --

UPDATE ecommerce_customer_churn
SET
    age = COALESCE(age, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY age) FROM ecommerce_customer_churn)),
    session_duration_avg = COALESCE(session_duration_avg, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY session_duration_avg) FROM ecommerce_customer_churn)),
    pages_per_session = COALESCE(pages_per_session, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY pages_per_session) FROM ecommerce_customer_churn)),
    wishlist_items = COALESCE(wishlist_items, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY wishlist_items) FROM ecommerce_customer_churn)),
    days_since_last_purchase = COALESCE(days_since_last_purchase, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY days_since_last_purchase) FROM ecommerce_customer_churn)),
    discount_usage_rate = COALESCE(discount_usage_rate, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY discount_usage_rate) FROM ecommerce_customer_churn)),
    returns_rate = COALESCE(returns_rate, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY returns_rate) FROM ecommerce_customer_churn)),
    email_open_rate = COALESCE(email_open_rate, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY email_open_rate) FROM ecommerce_customer_churn)),
    customer_service_calls = COALESCE(customer_service_calls, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY customer_service_calls) FROM ecommerce_customer_churn)),
    product_reviews_written = COALESCE(product_reviews_written, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY product_reviews_written) FROM ecommerce_customer_churn)),
    social_media_engagement_score = COALESCE(social_media_engagement_score, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY social_media_engagement_score) FROM ecommerce_customer_churn)),
    mobile_app_usage = COALESCE(mobile_app_usage, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY mobile_app_usage) FROM ecommerce_customer_churn)),
    payment_method_diversity = COALESCE(payment_method_diversity, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY payment_method_diversity) FROM ecommerce_customer_churn)),
    credit_balance = COALESCE(credit_balance, (SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY credit_balance) FROM ecommerce_customer_churn));

-- checking again to see if there are still any missing values --
SELECT
    COUNT(*) - COUNT(age) AS age_missing,
    COUNT(*) - COUNT(session_duration_avg) AS session_duration_missing,
    COUNT(*) - COUNT(pages_per_session) AS pages_missing,
    COUNT(*) - COUNT(wishlist_items) AS wishlist_missing,
    COUNT(*) - COUNT(days_since_last_purchase) AS last_purchase_missing,
    COUNT(*) - COUNT(discount_usage_rate) AS discount_missing,
    COUNT(*) - COUNT(returns_rate) AS returns_missing,
    COUNT(*) - COUNT(email_open_rate) AS email_missing,
    COUNT(*) - COUNT(customer_service_calls) AS service_calls_missing,
    COUNT(*) - COUNT(product_reviews_written) AS reviews_missing,
    COUNT(*) - COUNT(social_media_engagement_score) AS social_missing,
    COUNT(*) - COUNT(mobile_app_usage) AS mobile_missing,
    COUNT(*) - COUNT(payment_method_diversity) AS payment_missing,
    COUNT(*) - COUNT(credit_balance) AS credit_missing
FROM ecommerce_customer_churn;

-- We are done here with data cleaning--

/* In this step we are going to validate the data */

SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    MIN(login_frequency) AS min_logins,
    MAX(login_frequency) AS max_logins,
    MIN(session_duration_avg) AS min_session,
    MAX(session_duration_avg) AS max_session,
    MIN(pages_per_session) AS min_pages,
    MAX(pages_per_session) AS max_pages,
    MIN(cart_abandonment_rate) AS min_cart_abandonment,
    MAX(cart_abandonment_rate) AS max_cart_abandonment,
    MIN(discount_usage_rate) AS min_discount,
    MAX(discount_usage_rate) AS max_discount,
    MIN(returns_rate) AS min_returns,
    MAX(returns_rate) AS max_returns,
    MIN(email_open_rate) AS min_email_open,
    MAX(email_open_rate) AS max_email_open,
    MIN(mobile_app_usage) AS min_mobile_usage,
    MAX(mobile_app_usage) AS max_mobile_usage,
    MIN(social_media_engagement_score) AS min_social,
    MAX(social_media_engagement_score) AS max_social,
    MIN(churned) AS min_churned,
    MAX(churned) AS max_churned
FROM ecommerce_customer_churn;

/* we see after querying, that there are a few columns which are in unusual bounds
so we will fix it now */

SELECT COUNT(*) AS invalid_age
FROM ecommerce_customer_churn
WHERE age < 18 OR age > 100;

-- Fixing invalid age --

UPDATE ecommerce_customer_churn
SET age = (
    SELECT PERCENTILE_CONT(0.5)
           WITHIN GROUP (ORDER BY age)
    FROM ecommerce_customer_churn
    WHERE age BETWEEN 18 AND 100
)
WHERE age < 18 OR age > 100;

-- Verifying --
SELECT MIN(age) AS min_age,
       MAX(age) AS max_age
FROM ecommerce_customer_churn;

-- FIxing cart_abandonment column --

UPDATE ecommerce_customer_churn
SET cart_abandonment_rate = NULL
WHERE cart_abandonment_rate > 100;

UPDATE ecommerce_customer_churn
SET cart_abandonment_rate = (
    SELECT PERCENTILE_CONT(0.5)
    WITHIN GROUP (ORDER BY cart_abandonment_rate)
    FROM ecommerce_customer_churn
    WHERE cart_abandonment_rate <= 100
)
WHERE cart_abandonment_rate IS NULL;

-- Verifying --

SELECT
    MIN(cart_abandonment_rate) AS min_value,
    MAX(cart_abandonment_rate) AS max_value,
    COUNT(*) FILTER (WHERE cart_abandonment_rate > 100) AS invalid_values
FROM ecommerce_customer_churn;

-- Fixing Discount_Usage_rate column --

UPDATE ecommerce_customer_churn
SET discount_usage_rate = NULL
WHERE discount_usage_rate > 100;

-- Filling them with median --

UPDATE ecommerce_customer_churn
SET discount_usage_rate = (
    SELECT PERCENTILE_CONT(0.5)
    WITHIN GROUP (ORDER BY discount_usage_rate)
    FROM ecommerce_customer_churn
    WHERE discount_usage_rate <= 100
)
WHERE discount_usage_rate IS NULL;

-- Verifying --

SELECT
    MIN(discount_usage_rate) AS min_value,
    MAX(discount_usage_rate) AS max_value,
    COUNT(*) FILTER (
        WHERE discount_usage_rate > 100
    ) AS invalid_values
FROM ecommerce_customer_churn;


