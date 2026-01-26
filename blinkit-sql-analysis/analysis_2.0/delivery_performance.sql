/* =====================================================
   METRIC: Delivery Delay Analysis
   - Overall on-time delivery rate
   - Delay rate by City and Peak/Non-Peak hours
   - Top 5 worst-performing cities by delay rate
   ===================================================== */

-- PART 1: Overall On-Time Delivery Rate
WITH delivery_data AS (
    SELECT
        dm.order_id,
        dm.delivery_result,
        fo.area AS city,
        EXTRACT(HOUR FROM dm.order_date) AS order_hour,
        CASE
            WHEN EXTRACT(HOUR FROM dm.order_date) BETWEEN 17 AND 21
            THEN 'Peak Hours'
            ELSE 'Non-Peak Hours'
        END AS time_period
    FROM delivery_metrics dm
    JOIN fact_orders fo
        ON dm.order_id = fo.order_id
),

overall_metrics AS (
    SELECT
        COUNT(*) AS total_orders,
        SUM(CASE WHEN delivery_result = 'On Time' THEN 1 ELSE 0 END) AS on_time_deliveries,
        SUM(CASE WHEN delivery_result = 'Slightly Delayed' THEN 1 ELSE 0 END) AS slight_delays,
        SUM(CASE WHEN delivery_result = 'Significantly Delayed' THEN 1 ELSE 0 END) AS significant_delays
    FROM delivery_data
)

SELECT
    total_orders,
    on_time_deliveries,
    slight_delays,
    significant_delays,
    (slight_delays + significant_delays) AS total_delays,
    ROUND((on_time_deliveries::DECIMAL / total_orders) * 100, 2) AS on_time_rate_pct,
    ROUND(((slight_delays + significant_delays)::DECIMAL / total_orders) * 100, 2) AS overall_delay_rate_pct,
    ROUND((significant_delays::DECIMAL / total_orders) * 100, 2) AS significant_delay_rate_pct
FROM overall_metrics;

-- PART 2: Delay Rate by City
WITH delivery_data AS (
    SELECT
        dm.order_id,
        dm.delivery_result,
        fo.area AS city
    FROM delivery_metrics dm
    JOIN fact_orders fo
        ON dm.order_id = fo.order_id
),

city_metrics AS (
    SELECT
        city,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN delivery_result = 'On Time' THEN 1 ELSE 0 END) AS on_time_deliveries,
        SUM(CASE WHEN delivery_result = 'Slightly Delayed' THEN 1 ELSE 0 END) AS slight_delays,
        SUM(CASE WHEN delivery_result = 'Significantly Delayed' THEN 1 ELSE 0 END) AS significant_delays,
        ROUND(
            ((SUM(CASE WHEN delivery_result IN ('Slightly Delayed', 'Significantly Delayed') THEN 1 ELSE 0 END)::DECIMAL) / COUNT(*)) * 100,
            2
        ) AS overall_delay_rate_pct,
        ROUND(
            ((SUM(CASE WHEN delivery_result = 'Significantly Delayed' THEN 1 ELSE 0 END)::DECIMAL) / COUNT(*)) * 100,
            2
        ) AS significant_delay_rate_pct
    FROM delivery_data
    GROUP BY city
)

SELECT
    city,
    total_orders,
    on_time_deliveries,
    slight_delays,
    significant_delays,
    ROUND((on_time_deliveries::DECIMAL / total_orders) * 100, 2) AS on_time_rate_pct,
    overall_delay_rate_pct,
    significant_delay_rate_pct
FROM city_metrics
ORDER BY overall_delay_rate_pct DESC, significant_delay_rate_pct DESC;

-- PART 3: Delay Rate by Peak vs Non-Peak Hours
WITH delivery_data AS (
    SELECT
        dm.order_id,
        dm.delivery_result,
        CASE
            WHEN EXTRACT(HOUR FROM dm.order_date) BETWEEN 17 AND 21
            THEN 'Peak Hours'
            ELSE 'Non-Peak Hours'
        END AS time_period
    FROM delivery_metrics dm
    JOIN fact_orders fo
        ON dm.order_id = fo.order_id
),

peak_metrics AS (
    SELECT
        time_period,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN delivery_result = 'On Time' THEN 1 ELSE 0 END) AS on_time_deliveries,
        SUM(CASE WHEN delivery_result = 'Slightly Delayed' THEN 1 ELSE 0 END) AS slight_delays,
        SUM(CASE WHEN delivery_result = 'Significantly Delayed' THEN 1 ELSE 0 END) AS significant_delays,
        ROUND(
            ((SUM(CASE WHEN delivery_result IN ('Slightly Delayed', 'Significantly Delayed') THEN 1 ELSE 0 END)::DECIMAL) / COUNT(*)) * 100,
            2
        ) AS overall_delay_rate_pct,
        ROUND(
            ((SUM(CASE WHEN delivery_result = 'Significantly Delayed' THEN 1 ELSE 0 END)::DECIMAL) / COUNT(*)) * 100,
            2
        ) AS significant_delay_rate_pct
    FROM delivery_data
    GROUP BY time_period
)

SELECT
    time_period,
    total_orders,
    on_time_deliveries,
    slight_delays,
    significant_delays,
    ROUND((on_time_deliveries::DECIMAL / total_orders) * 100, 2) AS on_time_rate_pct,
    overall_delay_rate_pct,
    significant_delay_rate_pct
FROM peak_metrics
ORDER BY overall_delay_rate_pct DESC;

-- PART 4: Top 5 Worst-Performing Cities by Delay Rate
WITH delivery_data AS (
    SELECT
        dm.order_id,
        dm.delivery_result,
        fo.area AS city
    FROM delivery_metrics dm
    JOIN fact_orders fo
        ON dm.order_id = fo.order_id
),

city_metrics AS (
    SELECT
        city,
        COUNT(*) AS total_orders,
        SUM(CASE WHEN delivery_result = 'On Time' THEN 1 ELSE 0 END) AS on_time_deliveries,
        SUM(CASE WHEN delivery_result = 'Slightly Delayed' THEN 1 ELSE 0 END) AS slight_delays,
        SUM(CASE WHEN delivery_result = 'Significantly Delayed' THEN 1 ELSE 0 END) AS significant_delays,
        ROUND(
            ((SUM(CASE WHEN delivery_result IN ('Slightly Delayed', 'Significantly Delayed') THEN 1 ELSE 0 END)::DECIMAL) / COUNT(*)) * 100,
            2
        ) AS overall_delay_rate_pct,
        ROUND(
            ((SUM(CASE WHEN delivery_result = 'Significantly Delayed' THEN 1 ELSE 0 END)::DECIMAL) / COUNT(*)) * 100,
            2
        ) AS significant_delay_rate_pct
    FROM delivery_data
    GROUP BY city
    HAVING COUNT(*) >= 10  -- Filter cities with meaningful order volume
)

SELECT
    city,
    total_orders,
    on_time_deliveries,
    slight_delays,
    significant_delays,
    ROUND((on_time_deliveries::DECIMAL / total_orders) * 100, 2) AS on_time_rate_pct,
    overall_delay_rate_pct,
    significant_delay_rate_pct
FROM city_metrics
ORDER BY significant_delay_rate_pct DESC, overall_delay_rate_pct DESC
LIMIT 5;