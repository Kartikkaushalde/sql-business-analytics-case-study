USE business_analytics;

-- Production-style data quality checks.
SELECT 'Orders with invalid customer' AS check_name, COUNT(*) AS failures
FROM orders o LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL
UNION ALL
SELECT 'Orders with invalid employee', COUNT(*)
FROM orders o LEFT JOIN employees e ON o.employee_id = e.employee_id
WHERE o.employee_id IS NOT NULL AND e.employee_id IS NULL
UNION ALL
SELECT 'Order items with non-positive quantity', COUNT(*)
FROM order_items WHERE quantity <= 0
UNION ALL
SELECT 'Order items with invalid discount', COUNT(*)
FROM order_items WHERE discount_pct < 0 OR discount_pct > 100
UNION ALL
SELECT 'Orders with no line items', COUNT(*)
FROM orders o LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.order_id IS NULL
UNION ALL
SELECT 'Duplicate order IDs', COUNT(*) - COUNT(DISTINCT order_id)
FROM orders;

-- Revenue reconciliation: line-item revenue should be non-negative.
SELECT
    COUNT(*) AS line_items_checked,
    SUM(quantity * unit_price * (1 - COALESCE(discount_pct,0) / 100)) AS calculated_gross_revenue,
    SUM(CASE WHEN quantity > 0 AND unit_price >= 0 AND discount_pct BETWEEN 0 AND 100 THEN 1 ELSE 0 END) AS valid_line_items
FROM order_items;
