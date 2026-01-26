/* =====================================================
   METRIC: Marketing Channel Performance Analysis (Simplified)
   Based on campaign-level metrics from marketing_performance
   ===================================================== */

WITH channel_metrics AS (
    SELECT
        channel,
        SUM(conversions) AS total_conversions,
        SUM(revenue_generated) AS total_revenue_generated,
        SUM(spend) AS total_spend,
        SUM(impressions) AS total_impressions,
        SUM(clicks) AS total_clicks,
        ROUND(
            (SUM(revenue_generated)::DECIMAL / NULLIF(SUM(conversions), 0)),
            2
        ) AS revenue_per_conversion
    FROM marketing_performance
    GROUP BY channel
),

overall_totals AS (
    SELECT
        SUM(total_conversions) AS grand_total_conversions,
        SUM(total_revenue_generated) AS grand_total_revenue,
        AVG(revenue_per_conversion) AS avg_revenue_per_conversion_overall
    FROM channel_metrics
)

SELECT
    cm.channel,
    cm.total_conversions,
    ROUND((cm.total_conversions::DECIMAL / ot.grand_total_conversions) * 100, 2) AS conversion_share_pct,
    cm.total_revenue_generated,
    ROUND((cm.total_revenue_generated::DECIMAL / ot.grand_total_revenue) * 100, 2) AS revenue_contribution_pct,
    cm.revenue_per_conversion,
    ROUND(ot.avg_revenue_per_conversion_overall, 2) AS avg_revenue_per_conversion_overall,
    cm.total_spend,
    ROUND((cm.total_revenue_generated::DECIMAL / NULLIF(cm.total_spend, 0)), 2) AS roas,
    CASE
        WHEN (cm.total_conversions::DECIMAL / ot.grand_total_conversions) * 100 > 
             (SELECT AVG((total_conversions::DECIMAL / grand_total_conversions) * 100) 
              FROM channel_metrics CROSS JOIN overall_totals)
             AND cm.revenue_per_conversion < ot.avg_revenue_per_conversion_overall
        THEN 'High Volume - Low Quality'
        WHEN (cm.total_conversions::DECIMAL / ot.grand_total_conversions) * 100 < 
             (SELECT AVG((total_conversions::DECIMAL / grand_total_conversions) * 100) 
              FROM channel_metrics CROSS JOIN overall_totals)
             AND cm.revenue_per_conversion > ot.avg_revenue_per_conversion_overall
        THEN 'Low Volume - High Quality'
        WHEN (cm.total_conversions::DECIMAL / ot.grand_total_conversions) * 100 > 
             (SELECT AVG((total_conversions::DECIMAL / grand_total_conversions) * 100) 
              FROM channel_metrics CROSS JOIN overall_totals)
             AND cm.revenue_per_conversion > ot.avg_revenue_per_conversion_overall
        THEN 'High Volume - High Quality'
        ELSE 'Low Volume - Low Quality'
    END AS channel_segment
FROM channel_metrics cm
CROSS JOIN overall_totals ot
ORDER BY 
    CASE 
        WHEN (cm.total_conversions::DECIMAL / ot.grand_total_conversions) * 100 > 
             (SELECT AVG((total_conversions::DECIMAL / grand_total_conversions) * 100) 
              FROM channel_metrics CROSS JOIN overall_totals)
             AND cm.revenue_per_conversion < ot.avg_revenue_per_conversion_overall
        THEN 1
        WHEN (cm.total_conversions::DECIMAL / ot.grand_total_conversions) * 100 < 
             (SELECT AVG((total_conversions::DECIMAL / grand_total_conversions) * 100) 
              FROM channel_metrics CROSS JOIN overall_totals)
             AND cm.revenue_per_conversion > ot.avg_revenue_per_conversion_overall
        THEN 2
        WHEN (cm.total_conversions::DECIMAL / ot.grand_total_conversions) * 100 > 
             (SELECT AVG((total_conversions::DECIMAL / grand_total_conversions) * 100) 
              FROM channel_metrics CROSS JOIN overall_totals)
             AND cm.revenue_per_conversion > ot.avg_revenue_per_conversion_overall
        THEN 3
        ELSE 4
    END,
    conversion_share_pct DESC;