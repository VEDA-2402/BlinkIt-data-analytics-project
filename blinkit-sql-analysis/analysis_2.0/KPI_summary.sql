/* =====================================================
   EXECUTIVE SUMMARY KPI TABLE
   Single row output with all key metrics for Power BI dashboard
   ===================================================== */

WITH order_metrics AS (
    SELECT
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(order_total) AS total_revenue
    FROM fact_orders
),

delivery_metrics AS (
    SELECT
        COUNT(*) AS total_deliveries,
        SUM(CASE WHEN delivery_result = 'On Time' THEN 1 ELSE 0 END) AS on_time_deliveries,
        AVG(delivery_time_minutes) AS avg_delivery_time_minutes
    FROM delivery_metrics
),

customer_metrics AS (
    SELECT
        COUNT(DISTINCT customer_id) AS total_customers,
        SUM(CASE WHEN total_orders > 1 THEN 1 ELSE 0 END) AS repeat_customers
    FROM (
        SELECT
            customer_id,
            COUNT(DISTINCT order_id) AS total_orders
        FROM fact_orders
        GROUP BY customer_id
    ) customer_order_counts
)

SELECT
    -- Order Metrics
    om.total_orders,
    ROUND(om.total_revenue, 2) AS total_revenue,
    
    -- Delivery Metrics
    ROUND(
        (dm.on_time_deliveries::DECIMAL / NULLIF(dm.total_deliveries, 0)) * 100,
        2
    ) AS delivery_success_rate_pct,
    ROUND(dm.avg_delivery_time_minutes, 2) AS avg_delivery_time_minutes,
    
    -- Customer Metrics
    ROUND(
        (cm.repeat_customers::DECIMAL / NULLIF(cm.total_customers, 0)) * 100,
        2
    ) AS repeat_customer_pct,
    
    -- Additional Context Metrics
    cm.total_customers,
    ROUND((om.total_revenue::DECIMAL / NULLIF(om.total_orders, 0)), 2) AS avg_order_value,
    ROUND((om.total_orders::DECIMAL / NULLIF(cm.total_customers, 0)), 2) AS avg_orders_per_customer
    
FROM order_metrics om
CROSS JOIN delivery_metrics dm
CROSS JOIN customer_metrics cm;