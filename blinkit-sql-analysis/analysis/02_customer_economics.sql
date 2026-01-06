/* =====================================================
   QUESTION 1: CUSTOMER ECONOMICS & DELIVERY RISK
   Database: BlinkIt-project
   Tables used:
     - fact_orders
     - delivery_metrics (view)
   ===================================================== */

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(order_total) AS total_revenue,
        AVG(order_total) AS avg_order_value
    FROM fact_orders
    GROUP BY customer_id
),

customer_delivery AS (
    SELECT
        fo.customer_id,
        COUNT(dm.order_id) AS delivery_attempts,
        SUM(
            CASE
                WHEN dm.delivery_result <> 'Delivered' THEN 1
                ELSE 0
            END
        ) AS delivery_issues
    FROM fact_orders fo
    JOIN delivery_metrics dm
        ON fo.order_id = dm.order_id
    GROUP BY fo.customer_id
),

customer_metrics AS (
    SELECT
        co.customer_id,
        co.total_orders,
        co.total_revenue,
        co.avg_order_value,
        ROUND(
            cd.delivery_issues::DECIMAL
            / NULLIF(cd.delivery_attempts, 0),
            2
        ) AS delivery_issue_rate
    FROM customer_orders co
    LEFT JOIN customer_delivery cd
        ON co.customer_id = cd.customer_id
)

SELECT
    customer_id,
    total_orders,
    total_revenue,
    avg_order_value,
    delivery_issue_rate,
    CASE
        WHEN total_revenue >= 5000
             AND delivery_issue_rate > 0.30
        THEN 'High Revenue – High Risk'
        WHEN total_revenue >= 5000
        THEN 'High Revenue – Low Risk'
        WHEN total_orders = 1
        THEN 'One-Time Customer'
        ELSE 'Low Value Customer'
    END AS customer_segment
FROM customer_metrics
ORDER BY total_revenue DESC;



