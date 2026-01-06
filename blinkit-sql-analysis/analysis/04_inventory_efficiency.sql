/* =====================================================
   QUESTION 3: PRODUCT SALES EFFICIENCY
   Database: BlinkIt-project
   Tables used:
     - fact_orders
   ===================================================== */

WITH product_sales AS (
    SELECT
        product_id,
        product_name,
        category,
        COUNT(DISTINCT order_id) AS total_orders,
        SUM(quantity) AS total_units_sold,
        SUM(order_total) AS total_revenue
    FROM fact_orders
    GROUP BY product_id, product_name, category
),

product_efficiency AS (
    SELECT
        product_id,
        product_name,
        category,
        total_orders,
        total_units_sold,
        total_revenue,
        ROUND(
            total_revenue / NULLIF(total_units_sold, 0),
            2
        ) AS revenue_per_unit
    FROM product_sales
)

SELECT
    product_id,
    product_name,
    category,
    total_orders,
    total_units_sold,
    total_revenue,
    revenue_per_unit,
    CASE
        WHEN revenue_per_unit >= 2500
        THEN 'High Value – Low Volume'
        WHEN revenue_per_unit BETWEEN 1000 AND 2499
        THEN 'Balanced Performer'
        ELSE 'Low Value – High Volume'
    END AS product_efficiency_segment
FROM product_efficiency
ORDER BY revenue_per_unit DESC;
