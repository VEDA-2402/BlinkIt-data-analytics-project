/* =====================================================
   QUESTION 4: DELIVERY PERFORMANCE & RELIABILITY
   Database: BlinkIt-project
   Tables used:
     - delivery_metrics (view)
   ===================================================== */

WITH delivery_summary AS (
    SELECT
        DATE(order_date) AS order_day,
        COUNT(order_id) AS total_deliveries,
        SUM(
            CASE
                WHEN delivery_result IN ('Cancelled', 'Failed', 'Delayed')
                THEN 1
                ELSE 0
            END
        ) AS delivery_issues,
        AVG(delivery_time_minutes) AS avg_delivery_time,
        AVG(distance_km) AS avg_distance
    FROM delivery_metrics
    GROUP BY DATE(order_date)
)

SELECT
    order_day,
    total_deliveries,
    delivery_issues,
    ROUND(
        delivery_issues::DECIMAL / NULLIF(total_deliveries, 0),
        2
    ) AS delivery_issue_rate,
    ROUND(avg_delivery_time, 2) AS avg_delivery_time_minutes,
    ROUND(avg_distance, 2) AS avg_distance_km,
    CASE
        WHEN delivery_issues::DECIMAL / NULLIF(total_deliveries, 0) = 0
        THEN 'Excellent Performance'
        WHEN delivery_issues::DECIMAL / NULLIF(total_deliveries, 0) <= 0.10
        THEN 'Acceptable Performance'
        ELSE 'Needs Attention'
    END AS delivery_performance_status
FROM delivery_summary
ORDER BY order_day;
