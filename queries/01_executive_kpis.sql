USE business_analytics;

WITH order_value AS (
    SELECT o.order_id, o.customer_id, o.employee_id, o.order_date,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100)) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY o.order_id, o.customer_id, o.employee_id, o.order_date
)
SELECT COUNT(*) AS completed_orders,
       COUNT(DISTINCT customer_id) AS active_customers,
       ROUND(SUM(revenue),2) AS total_revenue,
       ROUND(SUM(revenue)/COUNT(*),2) AS average_order_value,
       ROUND(SUM(revenue)/COUNT(DISTINCT customer_id),2) AS revenue_per_customer
FROM order_value;

-- Monthly revenue trend
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
       ROUND(SUM(revenue),2) AS revenue,
       COUNT(*) AS orders
FROM (
    SELECT o.order_id, o.order_date,
           SUM(oi.quantity * oi.unit_price * (1 - oi.discount_pct/100)) AS revenue
    FROM orders o JOIN order_items oi ON o.order_id=oi.order_id
    WHERE o.status='Completed'
    GROUP BY o.order_id,o.order_date
) x
GROUP BY month
ORDER BY month;
