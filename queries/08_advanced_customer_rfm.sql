USE business_analytics;

-- Advanced Customer RFM segmentation
-- Recency: days since latest completed order
-- Frequency: completed order count
-- Monetary: completed revenue after discounts
WITH customer_metrics AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.segment,
        MAX(o.order_date) AS last_order_date,
        COUNT(DISTINCT o.order_id) AS frequency,
        SUM(oi.quantity * oi.unit_price * (1 - COALESCE(oi.discount_pct,0) / 100)) AS monetary
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
       AND o.status = 'Completed'
    LEFT JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name, c.segment
), scored AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY COALESCE(last_order_date, '1900-01-01') DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency) AS f_score,
        NTILE(5) OVER (ORDER BY COALESCE(monetary,0)) AS m_score
    FROM customer_metrics
), segmented AS (
    SELECT *,
        CASE
            WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
            WHEN r_score >= 4 AND f_score >= 3 THEN 'Loyal'
            WHEN r_score <= 2 AND m_score >= 4 THEN 'At Risk - High Value'
            WHEN r_score <= 2 AND f_score <= 2 THEN 'Churn Risk'
            WHEN r_score >= 4 AND f_score <= 2 THEN 'New / Promising'
            ELSE 'Needs Attention'
        END AS rfm_segment
    FROM scored
)
SELECT *
FROM segmented
ORDER BY monetary DESC;
