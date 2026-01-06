CREATE TABLE marketing_performance (
    campaign_id BIGINT PRIMARY KEY,
    campaign_name VARCHAR(100),
    date TIMESTAMP,
    target_audience VARCHAR(50),
    channel VARCHAR(50),
    impressions BIGINT,
    clicks BIGINT,
    conversions BIGINT,
    spend DECIMAL(10,2),
    revenue_generated DECIMAL(10,2),
    roas DECIMAL(5,2)
);




