# SQL Business Analytics Case Study

**MySQL • Advanced SQL • Business Analytics • KPI Reporting**

An end-to-end SQL analytics case study designed to demonstrate how a Data Analyst turns operational data into measurable business insights.

## Business Context

A fictional multi-department company wants to understand employee performance, customer value, sales trends and operational efficiency. The analysis answers realistic management questions using a relational MySQL dataset.

## What This Project Demonstrates

- Business KPI design
- Data quality and NULL handling
- Multi-table JOINs
- Conditional aggregation
- CTEs
- Window functions
- Ranking and segmentation
- Time-based trend analysis
- Customer value analysis
- Employee performance analysis
- Management-ready recommendations

## Business Questions

### Executive KPIs
1. What are total revenue, customers, orders and average order value?
2. What percentage of customers are active?
3. Which departments generate the most revenue?

### Customer Analytics
4. Who are the highest-value customers?
5. Which customer segments contribute the most revenue?
6. Which customers have not purchased recently?
7. What is the average revenue per customer?

### Employee Analytics
8. Which employees generate the highest sales value?
9. How does employee performance compare within each department?
10. Which employees are above or below their department average?
11. What is the ranking of employees by revenue contribution?

### Business Trends
12. How does revenue change month over month?
13. Which products drive revenue growth?
14. What is the contribution of each department to total revenue?
15. Which customers account for the largest share of revenue?

## SQL Techniques

```text
SELECT / CASE / COALESCE
GROUP BY / HAVING
INNER & LEFT JOIN
Subqueries
CTEs
Window Functions
RANK / DENSE_RANK / ROW_NUMBER
LAG / LEAD
Running Totals
Conditional Aggregation
Date Functions
NULL Handling
```

## Repository Structure

```text
sql-business-analytics-case-study/
├── README.md
├── schema/
│   └── database_schema.sql
├── data/
│   └── sample_data.sql
├── queries/
│   ├── 01_executive_kpis.sql
│   ├── 02_customer_analysis.sql
│   ├── 03_employee_analysis.sql
│   ├── 04_product_analysis.sql
│   ├── 05_cte_analysis.sql
│   ├── 06_window_functions.sql
│   └── 07_business_insights.sql
└── docs/
    └── business_questions.md
```

## Analytical Approach

The project follows a business-first workflow:

**Business Question → Data Model → SQL Analysis → KPI → Insight → Recommendation**

The dataset is intentionally fictional so that the project can be reproduced without exposing private or proprietary company data.

## Example Insights

The final queries are designed to identify:

- Revenue concentration
- High-value and inactive customers
- Department-level performance gaps
- Employee performance relative to peers
- Product contribution to revenue
- Monthly growth and decline
- Business segments requiring management attention

## Skills Demonstrated

**SQL:** Advanced querying, relational analysis, KPI computation, performance segmentation

**Business Analytics:** Revenue analysis, customer analytics, employee performance, trend analysis

**Problem Solving:** Translating open-ended business questions into measurable SQL metrics

**Data Quality:** NULL handling, duplicate prevention and validation logic
