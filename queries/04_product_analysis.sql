USE business_analytics;

WITH product_sales AS (
    SELECT p.product_id,p.product_name,p.category,
           SUM(oi.quantity) AS units_sold,
           SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct/100)) AS revenue
    FROM products p
    JOIN order_items oi ON p.product_id=oi.product_id
    JOIN orders o ON oi.order_id=o.order_id
    WHERE o.status='Completed'
    GROUP BY p.product_id,p.product_name,p.category
)
SELECT product_name,category,units_sold,ROUND(revenue,2) AS revenue,
       ROUND(100*revenue/SUM(revenue) OVER(),2) AS revenue_share_pct,
       RANK() OVER(ORDER BY revenue DESC) AS revenue_rank
FROM product_sales
ORDER BY revenue_rank;

-- Category contribution
SELECT p.category,
       SUM(oi.quantity) AS units,
       ROUND(SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct/100)),2) AS revenue
FROM products p
JOIN order_items oi ON p.product_id=oi.product_id
JOIN orders o ON oi.order_id=o.order_id
WHERE o.status='Completed'
GROUP BY p.category
ORDER BY revenue DESC;
