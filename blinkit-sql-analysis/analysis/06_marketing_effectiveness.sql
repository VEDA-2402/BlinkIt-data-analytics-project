/* =====================================================
   QUESTION 5: MARKETING EFFECTIVENESS & CUSTOMER QUALITY
   Database: BlinkIt-project
   Tables used:
     - fact_orders
     - marketing_performance
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

marketing_customers AS (
    SELECT
        mp.customer_id,
        mp.channel
    FROM marketing_performance mp
),

marketing_quality AS (
    SELECT
        mc.channel,
        COUNT(DISTINCT mc.customer_id) AS customers_acquired,
        AVG(co.total_orders) AS avg_orders_per_customer,
        AVG(co.total_revenue) AS avg_revenue_per_customer,
        AVG(co.avg_order_value) AS avg_order_value
    FROM marketing_customers mc
    LEFT JOIN customer_orders co
        ON mc.customer_id = co.customer_id
    GROUP BY mc.channel
)

SELECT
    channel,
    customers_acquired,
    ROUND(avg_orders_per_customer, 2) AS avg_orders_per_customer,
    ROUND(avg_revenue_per_customer, 2) AS avg_revenue_per_customer,
    ROUND(avg_order_value, 2) AS avg_order_value,
    CASE
        WHEN avg_orders_per_customer >= 3
             AND avg_revenue_per_customer >= 5000
        THEN 'High Quality Channel'
        WHEN avg_orders_per_customer < 2
        THEN 'Low Quality Channel'
        ELSE 'Moderate Quality Channel'
    END AS channel_quality_segment
FROM marketing_quality
ORDER BY avg_revenue_per_customer DESC;

