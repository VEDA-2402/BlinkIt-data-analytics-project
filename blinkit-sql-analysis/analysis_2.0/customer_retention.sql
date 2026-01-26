/* =====================================================
   METRIC: Repeat vs One-Time Customer Analysis
   - % of repeat customers
   - Revenue contribution comparison
   - Average order value comparison
   ===================================================== */

WITH customer_order_counts AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(order_total) AS total_revenue,
        AVG(order_total) AS avg_order_value
    FROM fact_orders
    GROUP BY customer_id
),

customer_classification AS (
    SELECT
        customer_id,
        total_orders,
        total_revenue,
        avg_order_value,
        CASE
            WHEN total_orders > 1 THEN 'Repeat Customer'
            ELSE 'One-Time Customer'
        END AS customer_type
    FROM customer_order_counts
),

customer_summary AS (
    SELECT
        customer_type,
        COUNT(DISTINCT customer_id) AS customer_count,
        SUM(total_revenue) AS total_revenue,
        AVG(avg_order_value) AS avg_order_value,
        SUM(total_orders) AS total_orders
    FROM customer_classification
    GROUP BY customer_type
),

overall_totals AS (
    SELECT
        SUM(customer_count) AS grand_total_customers,
        SUM(total_revenue) AS grand_total_revenue
    FROM customer_summary
)

SELECT
    cs.customer_type,
    cs.customer_count,
    ROUND((cs.customer_count::DECIMAL / ot.grand_total_customers) * 100, 2) AS customer_percentage,
    cs.total_revenue,
    ROUND((cs.total_revenue::DECIMAL / ot.grand_total_revenue) * 100, 2) AS revenue_contribution_pct,
    ROUND(cs.avg_order_value, 2) AS avg_order_value,
    cs.total_orders,
    ROUND((cs.total_revenue::DECIMAL / cs.total_orders), 2) AS revenue_per_order
FROM customer_summary cs
CROSS JOIN overall_totals ot
ORDER BY 
    CASE cs.customer_type
        WHEN 'Repeat Customer' THEN 1
        ELSE 2
    END;