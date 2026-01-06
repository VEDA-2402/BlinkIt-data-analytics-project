/* =====================================================
   QUESTION 2: PRODUCT PERFORMANCE & OPERATIONAL RISK
   Database: BlinkIt-project
   Tables used:
     - fact_orders
     - delivery_metrics
   ===================================================== */

WITH product_sales AS (
    SELECT
        product_id,
        product_name,
        category,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(quantity) AS total_units_sold,
        SUM(order_total) AS total_revenue,
        AVG(order_total) AS avg_order_value
    FROM fact_orders
    GROUP BY product_id, product_name, category
),

product_delivery AS (
    SELECT
        fo.product_id,
        COUNT(dm.order_id) AS delivery_attempts,
        SUM(
            CASE
                WHEN dm.delivery_result IN ('Cancelled', 'Failed', 'Delayed')
                THEN 1
                ELSE 0
            END
        ) AS delivery_issues
    FROM fact_orders fo
    JOIN delivery_metrics dm
        ON fo.order_id = dm.order_id
    GROUP BY fo.product_id
),

product_metrics AS (
    SELECT
        ps.product_id,
        ps.product_name,
        ps.category,
        ps.total_orders,
        ps.total_units_sold,
        ps.total_revenue,
        ps.avg_order_value,
        ROUND(
            pd.delivery_issues::DECIMAL
            / NULLIF(pd.delivery_attempts, 0),
            2
        ) AS delivery_issue_rate
    FROM product_sales ps
    LEFT JOIN product_delivery pd
        ON ps.product_id = pd.product_id
)

SELECT
    product_id,
    product_name,
    category,
    total_orders,
    total_units_sold,
    total_revenue,
    avg_order_value,
    delivery_issue_rate,
    CASE
        WHEN total_units_sold >= 100
             AND delivery_issue_rate > 0.30
        THEN 'High Demand – High Risk'
        WHEN total_units_sold >= 100
        THEN 'High Demand – Stable'
        WHEN total_units_sold < 20
        THEN 'Low Demand Product'
        ELSE 'Moderate Performance'
    END AS product_status
FROM product_metrics
ORDER BY total_revenue DESC;
