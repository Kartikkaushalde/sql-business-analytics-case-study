USE business_analytics;

-- Monthly customer cohort retention matrix.
-- Cohort month = first completed purchase month.
WITH first_purchase AS (
    SELECT customer_id, MIN(order_date) AS first_order_date
    FROM orders
    WHERE status = 'Completed'
    GROUP BY customer_id
), activity AS (
    SELECT DISTINCT
        o.customer_id,
        DATE_FORMAT(fp.first_order_date, '%Y-%m') AS cohort_month,
        DATE_FORMAT(o.order_date, '%Y-%m') AS activity_month,
        TIMESTAMPDIFF(
            MONTH,
            DATE_FORMAT(fp.first_order_date, '%Y-%m-01'),
            DATE_FORMAT(o.order_date, '%Y-%m-01')
        ) AS months_since_cohort
    FROM orders o
    JOIN first_purchase fp ON o.customer_id = fp.customer_id
    WHERE o.status = 'Completed'
)
SELECT
    cohort_month,
    months_since_cohort,
    COUNT(DISTINCT customer_id) AS retained_customers
FROM activity
GROUP BY cohort_month, months_since_cohort
ORDER BY cohort_month, months_since_cohort;
