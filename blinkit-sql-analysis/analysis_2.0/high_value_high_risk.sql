/* =====================================================
   METRIC: High Value & High Risk Cities
   Cities with high revenue contribution AND significantly above-average delays
   ===================================================== */

WITH city_revenue AS (
    SELECT
        fo.area AS city,
        SUM(fo.order_total) AS total_revenue
    FROM fact_orders fo
    GROUP BY fo.area
),

city_delivery AS (
    SELECT
        fo.area AS city,
        COUNT(dm.order_id) AS total_orders,
        ROUND(
            ((SUM(CASE WHEN dm.delivery_result IN ('Slightly Delayed', 'Significantly Delayed') THEN 1 ELSE 0 END)::DECIMAL) / COUNT(dm.order_id)) * 100,
            2
        ) AS delay_rate_pct
    FROM fact_orders fo
    JOIN delivery_metrics dm
        ON fo.order_id = dm.order_id
    GROUP BY fo.area
),

city_combined AS (
    SELECT
        cr.city,
        cr.total_revenue,
        cd.total_orders,
        cd.delay_rate_pct
    FROM city_revenue cr
    JOIN city_delivery cd
        ON cr.city = cd.city
),

overall_metrics AS (
    SELECT
        SUM(total_revenue) AS grand_total_revenue,
        AVG(delay_rate_pct) AS avg_delay_rate_pct,
        PERCENTILE_CONT(0.70) WITHIN GROUP (ORDER BY total_revenue) AS revenue_threshold_70th_percentile,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY delay_rate_pct) AS delay_threshold_75th_percentile
    FROM city_combined
)

SELECT
    cc.city,
    ROUND((cc.total_revenue::DECIMAL / om.grand_total_revenue) * 100, 2) AS revenue_contribution_pct,
    cc.delay_rate_pct,
    ROUND(om.avg_delay_rate_pct, 2) AS avg_delay_rate_across_all_cities,
    ROUND(om.delay_threshold_75th_percentile::NUMERIC, 2) AS delay_threshold_75th_percentile,
    cc.total_orders,
    CASE
        WHEN cc.delay_rate_pct >= 40 THEN 'Critical Risk'
        WHEN cc.delay_rate_pct >= 35 THEN 'High Risk'
        ELSE 'Moderate Risk'
    END AS risk_severity
FROM city_combined cc
CROSS JOIN overall_metrics om
WHERE cc.total_revenue >= om.revenue_threshold_70th_percentile  -- Top 30% by revenue (high value)
      AND cc.delay_rate_pct > om.avg_delay_rate_pct  -- Above average delays
      AND cc.delay_rate_pct >= 35  -- Minimum 35% delay rate (high risk threshold)
      AND cc.total_orders >= 20  -- Minimum order volume for reliability
ORDER BY cc.delay_rate_pct DESC, revenue_contribution_pct DESC
LIMIT 20;  -- Top 20 cities