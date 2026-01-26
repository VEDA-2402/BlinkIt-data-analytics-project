/* =====================================================
   METRIC: Revenue Concentration Analysis
   Calculate % of total revenue from Top 10% and Top 20% customers
   ===================================================== */

WITH customer_revenue AS (
    SELECT
        customer_id,
        SUM(order_total) AS total_revenue
    FROM fact_orders
    GROUP BY customer_id
),

customer_ranked AS (
    SELECT
        customer_id,
        total_revenue,
        -- Calculate cumulative revenue and customer count for percentile calculation
        SUM(total_revenue) OVER (ORDER BY total_revenue DESC) AS cumulative_revenue,
        ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
        COUNT(*) OVER () AS total_customers
    FROM customer_revenue
),

revenue_totals AS (
    SELECT
        SUM(total_revenue) AS grand_total_revenue
    FROM customer_revenue
),

top_10_percent AS (
    SELECT
        SUM(total_revenue) AS top_10_revenue
    FROM customer_ranked
    WHERE revenue_rank <= CEIL(total_customers * 0.10)
),

top_20_percent AS (
    SELECT
        SUM(total_revenue) AS top_20_revenue
    FROM customer_ranked
    WHERE revenue_rank <= CEIL(total_customers * 0.20)
)

SELECT
    ROUND(
        (t10.top_10_revenue::DECIMAL / rt.grand_total_revenue) * 100,
        2
    ) AS top_10_percent_customers_revenue_pct,
    ROUND(
        (t20.top_20_revenue::DECIMAL / rt.grand_total_revenue) * 100,
        2
    ) AS top_20_percent_customers_revenue_pct,
    rt.grand_total_revenue AS total_revenue,
    t10.top_10_revenue AS top_10_revenue,
    t20.top_20_revenue AS top_20_revenue
FROM revenue_totals rt
CROSS JOIN top_10_percent t10
CROSS JOIN top_20_percent t20;