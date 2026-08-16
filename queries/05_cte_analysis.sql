USE business_analytics;

-- Department revenue compared with company revenue
WITH department_revenue AS (
    SELECT d.department_name,
           SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct/100)) AS revenue
    FROM departments d
    JOIN employees e ON d.department_id=e.department_id
    JOIN orders o ON e.employee_id=o.employee_id AND o.status='Completed'
    JOIN order_items oi ON o.order_id=oi.order_id
    GROUP BY d.department_name
), totals AS (
    SELECT SUM(revenue) AS company_revenue FROM department_revenue
)
SELECT dr.department_name,
       ROUND(dr.revenue,2) AS revenue,
       ROUND(100*dr.revenue/t.company_revenue,2) AS company_share_pct
FROM department_revenue dr CROSS JOIN totals t
ORDER BY dr.revenue DESC;

-- Customers with more than one completed order and above-average revenue
WITH customer_revenue AS (
    SELECT c.customer_id,c.customer_name,
           COUNT(DISTINCT o.order_id) AS order_count,
           SUM(oi.quantity*oi.unit_price*(1-oi.discount_pct/100)) AS revenue
    FROM customers c
    JOIN orders o ON c.customer_id=o.customer_id AND o.status='Completed'
    JOIN order_items oi ON o.order_id=oi.order_id
    GROUP BY c.customer_id,c.customer_name
)
SELECT *
FROM customer_revenue
WHERE order_count > 1
  AND revenue > (SELECT AVG(revenue) FROM customer_revenue)
ORDER BY revenue DESC;
