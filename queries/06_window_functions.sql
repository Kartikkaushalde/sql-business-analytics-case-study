USE business_analytics;

-- Monthly revenue with previous month and growth rate
WITH monthly AS (
    SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
           SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct/100)) AS revenue
    FROM orders o JOIN order_items oi ON o.order_id=oi.order_id
    WHERE o.status='Completed'
    GROUP BY DATE_FORMAT(o.order_date,'%Y-%m')
), comparison AS (
    SELECT month,revenue,
           LAG(revenue) OVER(ORDER BY month) AS previous_month_revenue
    FROM monthly
)
SELECT month,ROUND(revenue,2) AS revenue,
       ROUND(previous_month_revenue,2) AS previous_month_revenue,
       ROUND(100*(revenue-previous_month_revenue)/NULLIF(previous_month_revenue,0),2) AS mom_growth_pct
FROM comparison
ORDER BY month;

-- Running revenue total
WITH monthly AS (
    SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
           SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct/100)) AS revenue
    FROM orders o JOIN order_items oi ON o.order_id=oi.order_id
    WHERE o.status='Completed'
    GROUP BY DATE_FORMAT(o.order_date,'%Y-%m')
)
SELECT month,ROUND(revenue,2) AS revenue,
       ROUND(SUM(revenue) OVER(ORDER BY month),2) AS cumulative_revenue
FROM monthly;
