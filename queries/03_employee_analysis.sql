USE business_analytics;

WITH employee_sales AS (
    SELECT e.employee_id, e.employee_name, d.department_name,
           COUNT(DISTINCT o.order_id) AS completed_orders,
           COALESCE(SUM(oi.quantity * oi.unit_price * (1-oi.discount_pct/100)),0) AS revenue
    FROM employees e
    JOIN departments d ON e.department_id=d.department_id
    LEFT JOIN orders o ON e.employee_id=o.employee_id AND o.status='Completed'
    LEFT JOIN order_items oi ON o.order_id=oi.order_id
    GROUP BY e.employee_id,e.employee_name,d.department_name
), ranked AS (
    SELECT *,
           RANK() OVER(PARTITION BY department_name ORDER BY revenue DESC) AS department_rank,
           AVG(revenue) OVER(PARTITION BY department_name) AS department_avg
    FROM employee_sales
)
SELECT employee_name, department_name, completed_orders,
       ROUND(revenue,2) AS revenue,
       department_rank,
       ROUND(department_avg,2) AS department_avg,
       CASE WHEN revenue > department_avg THEN 'Above Average' ELSE 'At/Below Average' END AS performance_flag
FROM ranked
ORDER BY department_name, department_rank;
