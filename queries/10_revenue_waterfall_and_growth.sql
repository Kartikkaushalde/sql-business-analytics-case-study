USE business_analytics;

-- Revenue bridge by month with MoM growth and cumulative revenue.
WITH monthly AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m-01') AS month_start,
        SUM(oi.quantity * oi.unit_price * (1 - COALESCE(oi.discount_pct,0) / 100)) AS revenue,
        COUNT(DISTINCT o.order_id) AS orders,
        COUNT(DISTINCT o.customer_id) AS customers
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m-01')
), scored AS (
    SELECT *,
        LAG(revenue) OVER (ORDER BY month_start) AS previous_revenue,
        SUM(revenue) OVER (ORDER BY month_start ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_revenue
    FROM monthly
)
SELECT
    month_start,
    revenue,
    orders,
    customers,
    previous_revenue,
    revenue - previous_revenue AS revenue_change,
    ROUND(100 * (revenue - previous_revenue) / NULLIF(previous_revenue,0), 2) AS mom_growth_pct,
    cumulative_revenue
FROM scored
ORDER BY month_start;
