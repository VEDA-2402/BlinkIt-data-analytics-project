# Data Model & Table Relationships

## Overview
This project uses an **analytics-ready data model** designed to support business decision-making rather than raw transaction processing.  
The model follows a **fact-centric approach**, where a single fact table captures order-level activity and supporting tables/views provide operational and acquisition context.

---

## Core Tables

### fact_orders
**Grain:** One row per order–product combination  

This is the **primary fact table** used throughout the analysis.

**Key attributes include:**
- order_id
- customer_id
- order_date
- order_total
- product_id
- product_name
- category
- brand
- quantity
- unit_price
- customer_segment
- area

**Purpose:**
- Revenue and order analysis  
- Customer-level aggregation  
- Product and category performance  
- Sales efficiency calculations  

---

### delivery_metrics (View)
**Grain:** One row per order  

This view abstracts delivery-related logic into a clean, query-ready layer.

**Key attributes include:**
- order_id
- delivery_result
- delivery_time_minutes
- distance_km
- order_date

**Purpose:**
- Delivery reliability analysis  
- Operational performance monitoring  
- Funnel conversion measurement  

---

### marketing_performance
**Grain:** One row per customer acquisition record  

This table captures the **source of customer acquisition**.

**Key attributes include:**
- customer_id
- channel

**Purpose:**
- Marketing channel effectiveness  
- Customer quality analysis by acquisition source  

---

## Table Relationships

| From Table       | To Table              | Join Key     | Relationship Type |
|------------------|-----------------------|--------------|-------------------|
| fact_orders      | delivery_metrics      | order_id     | One-to-One        |
| fact_orders      | marketing_performance | customer_id  | Many-to-One       |

---

## Analytical Design Principles

- **Single Source of Truth**  
  fact_orders acts as the backbone for all revenue, customer, and product analysis.

- **Separation of Concerns**  
  Delivery logic is isolated in a view (delivery_metrics) to keep analytical queries clean and consistent.

- **Analytics-Ready Schema**  
  The model avoids raw transactional joins and supports fast aggregation and storytelling.

- **Data-Driven Flexibility**  
  Business questions were adapted to available data instead of forcing unavailable inventory or cost metrics.

---

## Why This Model Works Well for Analytics

- Minimizes complex joins  
- Reduces risk of inconsistent calculations  
- Mirrors real-world data warehouse design  
- Supports both operational and strategic analysis  

---

## Notes & Limitations
- Inventory-level data was not available; therefore, inventory efficiency analysis was intentionally excluded.
- Marketing cost and CAC metrics were not present, so marketing analysis focuses on **customer quality**, not spend efficiency.
