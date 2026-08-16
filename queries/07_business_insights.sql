USE business_analytics;

-- Revenue concentration: customers responsible for the majority of revenue
WITH customer_revenue AS (
    SELECT c.customer_id,c.customer_name,
           SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct/100)) AS revenue
    FROM customers c
    JOIN orders o ON c.customer_id=o.customer_id AND o.status='Completed'
    JOIN order_items oi ON o.order_id=oi.order_id
    GROUP BY c.customer_id,c.customer_name
), ranked AS (
    SELECT *,
           SUM(revenue) OVER() AS total_revenue,
           SUM(revenue) OVER(ORDER BY revenue DESC ROWS UNBOUNDED PRECEDING) AS cumulative_revenue
    FROM customer_revenue
)
SELECT customer_name,ROUND(revenue,2) AS revenue,
       ROUND(100*revenue/total_revenue,2) AS revenue_share_pct,
       ROUND(100*cumulative_revenue/total_revenue,2) AS cumulative_share_pct
FROM ranked
ORDER BY revenue DESC;

-- Discount impact by product
SELECT p.product_name,
       ROUND(SUM(oi.quantity*oi.unit_price),2) AS gross_value,
       ROUND(SUM(oi.quantity*oi.unit_price*oi.discount_pct/100),2) AS discount_value,
       ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct/100)),2) AS net_revenue
FROM products p
JOIN order_items oi ON p.product_id=oi.product_id
JOIN orders o ON oi.order_id=o.order_id
WHERE o.status='Completed'
GROUP BY p.product_name
ORDER BY discount_value DESC;

-- Cancelled order exposure
SELECT COUNT(*) AS cancelled_orders,
       ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct/100)),2) AS cancelled_value
FROM orders o
JOIN order_items oi ON o.order_id=oi.order_id
WHERE o.status='Cancelled';
