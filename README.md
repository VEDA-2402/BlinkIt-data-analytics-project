# 📊 Blinkit Business Intelligence & Analytics

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)

> **Transforming 5,000+ orders into decision-ready insights through dual-phase analytics: Power BI dashboards + deep SQL analysis**

---

## 📌 Situation

Blinkit operates in a **high-frequency quick-commerce environment** where sustainable growth depends on more than just order volume—it requires:
- High-quality, repeat customers
- Operationally reliable delivery systems
- Efficient marketing channel performance
- Minimal revenue leakage across the fulfillment funnel

Leadership faced a critical question:

> *"Are our customers, products, marketing channels, and delivery operations truly driving sustainable business value — or are we just growing numbers?"*

The challenge was to move beyond surface-level metrics and conduct **deep, SQL-driven analysis** that could validate business fundamentals and guide strategic decisions.

---

## 🎯 Task

Design and execute a **two-phase analytics project**:

### Phase 1: Business Overview & KPI Foundation
Build a comprehensive Power BI dashboard covering:
- Revenue concentration and customer segmentation
- Delivery reliability across time and geography
- Marketing channel ROI and customer quality
- Repeat vs one-time customer economics

### Phase 2: SQL-Driven Deep Dive (Analysis 2.0)
Answer business-critical questions through PostgreSQL analysis:
- Which customers are truly valuable long-term?
- Do top products create operational risk?
- Is delivery reliability limiting growth?
- Which marketing channels deliver quality vs noise?
- Is revenue realized or lost in the fulfillment funnel?

**Deliverable:** Actionable insights backed by data, not assumptions.

---

## 🛠 Action

### 🗄️ Data Architecture: Star Schema Design

Built a **scalable star schema** mirroring real-world data warehouse standards:

![Star Schema Diagram](blinkit-sql-analysis/schema/star-schema.png)

**Fact Table:**
- `fact_orders` – Order-level transactions (revenue, quantity, product, customer, geography)

**Dimension Tables / Views:**
- `delivery_metrics` (VIEW) – Delivery status, time, distance
- `marketing_performance` – Customer acquisition channels
- `dim_customers`, `dim_products`, `dim_cities`, `dim_dates`

**Benefits:**
- Fast aggregations across business dimensions
- Clean, maintainable joins
- Business-friendly metric computation

---

### 📊 Phase 1: Business Overview Dashboard

![BlinkIt Dashboard](blinkit-sql-analysis/assets/charts_or_exports/DASHBOARD.png)

**Dataset Overview:**
- **Total Orders:** 5,000  
- **Total Revenue:** ₹11.0M  
- **Customers:** 2,172  
- **Time Period:** Feb–Mar 2025 cohort, tracked through Jan 2026

**Key Insights Discovered:**

| Insight Area | Finding | Business Implication |
|-------------|---------|---------------------|
| **Revenue Concentration** | Top 20% of customers drive 40.9% of revenue (₹4.5M) | Retention > Acquisition |
| **Delivery Reliability** | 30.6% delay rate—consistent across peak/non-peak hours | Structural, not time-based issues |
| **Geographic Variance** | 15+ cities show 40%–50% delay rates | City-specific interventions needed |
| **Marketing Efficiency** | Email (2.05 ROAS) and SMS (1.99 ROAS) outperform App/Social | Channel quality > Volume |
| **Customer Retention** | Repeat customers (68.7%) generate 86.7% of revenue | Repeat behavior drives sustainability |

**Dashboard Components:**
- Executive KPI summary with drill-down capability
- Customer segmentation and value analysis
- Delivery performance heatmaps by time and location
- Marketing channel effectiveness comparison
- Revenue funnel visualization

---

### 🔍 Phase 2: SQL-Driven Analysis (Analysis 2.0)

**Focus:** Deep-dive into business fundamentals using PostgreSQL to validate operational health and growth sustainability.

#### **Q1: Customer Economics & Retention**
**Problem:** Are all high-revenue customers equally valuable?

**Approach:** Segmented customers by total revenue, order frequency, average order value, and delivery reliability.

**Finding:**  
Top revenue customers show **zero delivery issues**, making them ideal for retention programs. One-time customers contribute minimal long-term value (<5% LTV).

**Impact:** Prioritize loyalty programs for top 20% segment.

---

#### **Q2: Product Portfolio Health**
**Problem:** Do top-selling products introduce delivery or operational risk?

**Approach:** Evaluated products on orders, revenue, units sold, and delivery success rate.

**Finding:**  
High-performing products maintain **95%+ delivery success**. Revenue is driven by balanced, reliable SKUs—not fragile high-risk products.

**Impact:** Confident portfolio expansion without operational concern.

---

#### **Q3: Product Sales Efficiency (Revenue vs Volume)**
**Problem:** Which products depend on volume vs premium pricing?

**Approach:** Calculated revenue per unit to identify pricing efficiency patterns.

**Finding:**  
Most products fall into a **balanced efficiency zone**, supporting sustainable revenue without extreme dependency on volume or pricing.

**Impact:** Product strategy is fundamentally sound.

---

#### **Q4: Delivery Performance & Reliability**
**Problem:** Is delivery performance a growth bottleneck?

**Approach:** Tracked daily delivery success rate, average delivery time, and distance over time.

**Finding:**  
Delivery performance is **consistently strong (95%+ success)**. Operations are a competitive advantage, not a constraint.

**Impact:** Scale confidently—delivery won't break under growth.

---

#### **Q5: Marketing Effectiveness & Customer Quality**
**Problem:** Are marketing channels acquiring valuable customers or just traffic?

**Approach:** Measured post-acquisition behavior—orders per customer, revenue per customer, and average order value by channel.

**Finding:**  
Email and SMS drive **high-quality, repeat customers**. App and Social Media inflate volume but deliver lower lifetime value.

**Impact:** Reallocate marketing budget toward high-ROAS channels.

---

#### **Q6: End-to-End Funnel Performance**
**Problem:** Is revenue lost between order placement and delivery?

**Approach:** Compared order stage vs delivery stage revenue to calculate funnel leakage.

**Finding:**  
**Minimal value leakage**—order revenue is successfully realized through delivery. Funnel integrity is strong.

**Impact:** No hidden revenue loss—growth is real.

---

## ✅ Result

### Business Impact
✔ **Customer Strategy:** Identified top 20% segment driving 40.9% of revenue—enabled targeted retention  
✔ **Operational Confidence:** Validated delivery as a **competitive strength** (95%+ success), not a risk  
✔ **Marketing Optimization:** Shifted budget toward high-ROAS channels (Email, SMS)  
✔ **Product Portfolio:** Confirmed revenue driven by **stable, reliable SKUs**  
✔ **Growth Validation:** Proved business is building sustainable value, not inflating metrics

### Technical Achievements
- Designed production-grade **star schema** for scalable analytics
- Executed **dual-phase analysis**: Power BI dashboards + SQL deep-dive
- Built **6 business-critical analyses** answering strategic questions
- Delivered **executive-ready insights** for non-technical stakeholders
- Documented complete workflow following **professional analytics standards**

---

## 🧰 Tech Stack

| Tool | Purpose |
|------|---------|
| **PostgreSQL** | SQL queries, data modeling, business logic |
| **Python** | Data import automation & preprocessing |
| **Power BI** | Executive dashboards, KPIs, visualizations |
| **VS Code + pgAdmin** | Development environment & query validation |
| **GitHub** | Version control & project documentation |

---

## 📂 Project Structure

```
blinkit-sql-analysis/
│
├── blinkit-sql-analysis/          # Main analysis folder
│   ├── analysis/                  # Phase 1: Initial SQL queries
│   │   ├── 01_data_sanity_checks.sql
│   │   ├── 02_customer_economics.sql
│   │   ├── 03_product_portfolio.sql
│   │   ├── 04_product_sales_efficiency.sql
│   │   ├── 05_delivery_performance.sql
│   │   ├── 06_marketing_effectiveness.sql
│   │   └── 07_end_to_end_funnel.sql
│   │
│   ├── analysis_2.0/              # Phase 2: Deep-dive SQL analysis
│   │   ├── customer_deep_dive.sql
│   │   ├── product_analysis.sql
│   │   ├── delivery_analysis.sql
│   │   ├── marketing_analysis.sql
│   │   └── funnel_analysis.sql
│   │
│   ├── insights/                  # Phase 1: Business insights
│   │   ├── customer_insights.md
│   │   ├── product_insights.md
│   │   ├── sales_efficiency_insights.md
│   │   ├── delivery_insights.md
│   │   ├── marketing_insights.md
│   │   └── executive_summary.md
│   │
│   ├── insights_2.0.md           # Phase 2: Consolidated deep-dive insights
│   │
│   ├── data_model/               # Data modeling documentation
│   │   └── table_relationships.md
│   │
│   ├── schema/                   # Database schema diagrams
│   │   ├── star-schema.png
│   │   └── er_diagram.png
│   │
│   └── assets/                   # Visualizations & exports
│       └── charts_or_exports/
│           └── DASHBOARD.png
│
├── raw_data/                     # Raw data files
│
├── blinkit-dashboard.pbix        # Power BI dashboard file
├── importing_data_postgres.sql   # Database setup script
├── setup.py                      # Python setup automation
├── .gitignore                    # Git ignore configuration
├── LICENSE                       # Project license
└── README.md                     # Project documentation
```

---

## 🏁 Getting Started

### Prerequisites
- PostgreSQL 12+
- Python 3.8+
- Power BI Desktop
- pgAdmin (optional)

### Setup Instructions

**1. Clone the repository**
```bash
git clone https://github.com/VEDA-2402/blinkit-sql-analysis.git
cd blinkit-sql-analysis
```

**2. Set up the database**
```bash
python setup.py
# OR manually run:
psql -U your_username -d your_database -f importing_data_postgres.sql
```

**3. Run SQL analysis**
- Navigate to `blinkit-sql-analysis/analysis/` for Phase 1 queries
- Navigate to `blinkit-sql-analysis/analysis_2.0/` for Phase 2 deep-dive
- Execute queries in sequence
- Review insights in `insights/` and `insights_2.0.md`

**4. Open Power BI Dashboard**
- Open `blinkit-dashboard.pbix` in Power BI Desktop
- Refresh data connections if needed
- Explore interactive visualizations

---

## 🧪 Data Validation

Before analysis, comprehensive data sanity checks were performed:
- Table availability and structure validation
- Primary/foreign key integrity
- Null value handling and data completeness
- Date range consistency
- Join relationship verification

All conclusions are built on **trustworthy, validated data**.

---

## 👤 Author

**Veda Vedhya**  
*Data Analyst | SQL | Power BI | Business Intelligence*

- **GitHub:** [@VEDA-2402](https://github.com/VEDA-2402)
- **LinkedIn:** [Veda T](https://www.linkedin.com/in/veda-t-8b9a7134a/)
- **Email:** veda.vedhya240205@gmail.com

---

## 📄 License

This project is licensed under the MIT License.

---

**⭐ If you found this project valuable, consider starring the repository!**
