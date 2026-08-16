USE business_analytics;

WITH customer_revenue AS (
    SELECT c.customer_id, c.customer_name, c.segment,
           COUNT(DISTINCT o.order_id) AS orders,
           COALESCE(SUM(oi.quantity * oi.unit_price * (1-oi.discount_pct/100)),0) AS revenue,
           MAX(o.order_date) AS last_order_date
    FROM customers c
    LEFT JOIN orders o ON c.customer_id=o.customer_id AND o.status='Completed'
    LEFT JOIN order_items oi ON o.order_id=oi.order_id
    GROUP BY c.customer_id,c.customer_name,c.segment
)
SELECT *,
       DENSE_RANK() OVER (ORDER BY revenue DESC) AS revenue_rank,
       CASE
         WHEN revenue >= 5000 THEN 'High Value'
         WHEN revenue >= 2500 THEN 'Medium Value'
         ELSE 'Low Value'
       END AS value_segment
FROM customer_revenue
ORDER BY revenue_rank;

-- Customers with missing emails
SELECT customer_id, customer_name, segment
FROM customers
WHERE email IS NULL;
