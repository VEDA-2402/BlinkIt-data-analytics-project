# 📊 Blinkit Delivery & Growth Analytics — Insights

## 📌 Project Objective

The objective of this analysis was to evaluate revenue concentration, delivery reliability, customer behavior, and marketing effectiveness using transactional order data modeled in a star schema.

The goal was not just to build dashboards, but to answer real business questions and derive actionable, decision-ready insights.

---

## 🧱 Data Overview & Modeling Approach

- **Total Orders Analyzed:** 5,000
- **Total Customers:** 2,172
- **Total Revenue:** ₹11,009,308.50
- **Time Period:** Feb–Mar 2025 cohort, tracked through Jan 2026

### Modeling Approach: Star Schema

- Fact table capturing orders, revenue, delivery status, and timestamps
- Dimension tables for customers, locations (cities), products, dates, and marketing channels

The star schema enabled:
- Faster aggregations
- Consistent KPI computation
- Scalable analysis across multiple business dimensions

---

## 1️⃣ Revenue Concentration Analysis

### Business Question:
*Is revenue evenly distributed across customers, or concentrated among a small segment?*

### 🔍 Results

- **Top 10% of customers** contributed ~24.1% of total revenue
- **Top 20% of customers** contributed ~40.9% of total revenue (₹4.5M out of ₹11.0M)

### 🧠 Interpretation

Revenue is meaningfully concentrated, but not excessively skewed. This indicates that:
- A relatively small customer segment drives a large share of revenue
- Growth can be achieved more efficiently through retention and engagement of high-value customers, rather than pure acquisition

### 🎯 Business Implication

- Focus loyalty programs, retention offers, and personalized experiences on the top 20% segment
- Losing even a small fraction of this cohort would have a disproportionate revenue impact

---

## 2️⃣ Overall Delivery Reliability

### Business Question:
*How reliable is the delivery operation, and how often are customers impacted by delays?*

### 🔍 Results

- **On-time delivery rate:** 69.4%
- **Overall delay rate:** 30.6%
  - Slight delays: 20.7%
  - Significant delays: 9.86%

### 🧠 Interpretation

Nearly 1 in 3 orders experiences a delay, which is a critical operational risk for a quick-commerce platform where delivery speed directly impacts customer satisfaction and repeat usage.

### 🎯 Business Implication

- Delivery reliability is a core pain point
- Improvements in logistics efficiency could directly improve retention and order frequency

---

## 3️⃣ Peak vs Non-Peak Hour Analysis

### Business Question:
*Are delivery delays primarily caused by peak-hour demand surges?*

### 🔍 Results

| Time Period      | On-Time Rate | Delay Rate |
|------------------|--------------|------------|
| Peak Hours       | 70.83%       | 29.17%     |
| Non-Peak Hours   | 69.01%       | 30.99%     |

### 🧠 Interpretation

Contrary to common assumptions:
- Delay rates are consistently high across both peak and non-peak hours
- Peak demand alone is not the primary driver of delivery failures

### 🎯 Business Implication

- Delays are more likely caused by structural issues (routing inefficiencies, partner availability, operational processes)
- Simply adding peak-hour capacity will not fully solve the problem

---

## 4️⃣ City-Level Delivery Performance

### Business Question:
*Which cities are experiencing the worst delivery reliability?*

### 🔍 Results

- **Average delay rate across all cities:** 31.41%
- **75th percentile delay threshold:** 38.89%
- **15+ cities** exceed this threshold, with delay rates between 40%–50%

**Examples:**
- Ghaziabad: 43.75% delay rate
- Thoothukudi: 50.00% delay rate
- Bijapur: 47.83% delay rate

### 🧠 Interpretation

Delivery reliability varies significantly by geography. Certain cities face systemic operational challenges, independent of overall demand volume.

### 🎯 Business Implication

- City-specific interventions are required
- Blanket national strategies may not address localized operational failures

---

## 5️⃣ High-Risk vs Revenue Contribution Analysis

### Business Question:
*Are high-revenue cities also the ones with the highest delivery risk?*

### 🔍 Results

- Several cities show very high delay rates (40%–50%)
- Most of these cities contribute <1% of total revenue individually

### 🧠 Interpretation

High delay rates are not always correlated with high revenue contribution. This helps distinguish:
- Cities where operational fixes protect significant revenue
- Cities where issues can be deprioritized without major financial impact

### 🎯 Business Implication

- Enables risk-based prioritization
- Operational resources can be allocated where both risk and business impact intersect

---

## 6️⃣ Marketing Channel Performance & Quality

### Business Question:
*Which acquisition channels deliver high-quality customers versus just high volume?*

### 🔍 Results

| Channel       | Revenue Contribution | ROAS | Segment                    |
|---------------|---------------------|------|----------------------------|
| Email         | 25.44%              | 2.05 | High Volume – High Quality |
| SMS           | 24.66%              | 1.99 | Low Volume – High Quality  |
| App           | 25.08%              | 1.92 | High Volume – Low Quality  |
| Social Media  | 24.82%              | 1.94 | High Volume – Low Quality  |

### 🧠 Interpretation

- Email and SMS deliver better revenue per conversion
- App and Social Media drive volume, but lower efficiency
- Not all growth channels contribute equally to profitability

### 🎯 Business Implication

- Marketing budgets should shift toward high-ROAS channels
- Volume-heavy but low-quality channels should be optimized, not blindly scaled

---

## 7️⃣ Repeat vs One-Time Customer Analysis

### Business Question:
*How important are repeat customers to overall revenue?*

### 🔍 Results

- **Repeat customers:** 68.7% of customers
- **Revenue contribution:** ~86.7%
- Higher average order value than one-time customers

### 🧠 Interpretation

Repeat customers are the primary revenue engine of the business. Acquisition without retention leads to diminishing returns.

### 🎯 Business Implication

- Retention initiatives yield significantly higher ROI than pure acquisition
- Delivery reliability directly affects repeat behavior

---

## 8️⃣ Executive KPI Summary

### Key Metrics Delivered to Dashboard

- **Total Orders:** 5,000
- **Total Revenue:** ₹11.0M
- **Delivery Success Rate:** 69.4%
- **Average Delivery Time:** 4.44 minutes
- **Repeat Customer Share:** 68.7%
- **Average Order Value:** ₹2,202

These KPIs were integrated into an executive Power BI dashboard designed for non-technical stakeholders.

---

## 🧠 Final Strategic Takeaways

1. **Retention > Acquisition**  
   A small segment of customers drives a disproportionate share of revenue.

2. **Delivery reliability is the biggest growth lever**  
   Reducing delays has a direct impact on repeat usage and customer lifetime value.

3. **Operational issues are structural, not time-based**  
   Peak-hour scaling alone is insufficient.

4. **Marketing efficiency matters more than volume**  
   Channel quality varies significantly.

---

## ✅ Outcome

This analysis transformed raw transactional data into decision-ready insights, enabling:

- Targeted operational interventions
- Smarter marketing spend allocation
- Clear prioritization of risk vs reward