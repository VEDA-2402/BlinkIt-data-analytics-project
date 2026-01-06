/* =====================================================
   QUESTION 6: END-TO-END FUNNEL PERFORMANCE
   Database: BlinkIt-project
   Tables used:
     - fact_orders
     - delivery_metrics (view)
   ===================================================== */

WITH order_stage AS (
    SELECT
        COUNT(DISTINCT order_id) AS orders_placed,
        SUM(order_total) AS gross_revenue
    FROM fact_orders
),

delivery_stage AS (
    SELECT
        COUNT(DISTINCT order_id) AS delivery_attempts,
        SUM(
            CASE
                WHEN delivery_result IN ('Cancelled', 'Failed', 'Delayed')
                THEN 1
                ELSE 0
            END
        ) AS failed_deliveries,
        SUM(
            CASE
                WHEN delivery_result NOT IN ('Cancelled', 'Failed', 'Delayed')
                THEN 1
                ELSE 0
            END
        ) AS successful_deliveries
    FROM delivery_metrics
)

SELECT
    os.orders_placed,
    ds.delivery_attempts,
    ds.successful_deliveries,
    ds.failed_deliveries,
    ROUND(
        ds.successful_deliveries::DECIMAL
        / NULLIF(ds.delivery_attempts, 0),
        2
    ) AS delivery_success_rate,
    os.gross_revenue
FROM order_stage os
CROSS JOIN delivery_stage ds;
