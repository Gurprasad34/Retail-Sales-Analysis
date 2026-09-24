# Retail Sales Analysis

## Project Overview

This project analyzes retail transaction data to identify sales trends, product performance, purchasing behavior, and differences between online and in-store sales.

I built an end-to-end analytics workflow using **SQL, Excel, and Tableau**, taking the project from raw data through cleaning, analysis, visualization, and business insights.

**Workflow:** Raw CSV → MySQL → SQL Analysis → Excel → Tableau → Business Insights

---

## Tools Used

- **MySQL / SQL** — data cleaning, validation, exploration, and business analysis
- **Excel** — formulas, PivotTables, KPI analysis, and data validation
- **Tableau** — interactive dashboard and visualizations
- **VS Code** — SQL development and project organization
- **GitHub** — version control and project documentation

---

## Business Questions

The analysis focused on several key questions:

- How much revenue did the business generate?
- How did revenue change over time?
- Which categories and products generated the most revenue?
- How did online and in-store sales compare?
- Which payment methods were most commonly used?
- How did discounted and non-discounted sales compare?

---

## Data Cleaning

The raw dataset contained **11,362 transactions** from January 2022 through January 18, 2025.

Using SQL, I:

- Checked for duplicates, NULLs, blanks, and inconsistent values
- Validated transaction dates and numeric ranges
- Standardized column names
- Converted transaction dates from text to `DATE`
- Converted quantity to `INT`
- Converted monetary fields to `DECIMAL(10,2)`
- Converted blank discount values to `NULL` rather than assuming they represented no discount
- Validated `Total Spent` against price and quantity

---

## SQL Analysis

SQL was used to explore the data and answer business questions using techniques including:

`GROUP BY` • `CASE` • CTEs • Subqueries • Window Functions • `RANK()` • `LAG()` • `COUNT(DISTINCT)` • Date Functions

### Key KPIs

| Metric | Result |
|---|---:|
| Total Revenue | $1,472,998.50 |
| Total Transactions | 11,362 |
| Average Transaction Value | $129.64 |
| Total Quantity Sold | 62,889 |

---

## Excel Analysis

The cleaned data was exported to Excel for additional spreadsheet-based analysis.

Excel was used for:

- Formulas such as `IF`, `SUMIFS`, `COUNTIFS`, and `XLOOKUP`
- PivotTables and PivotCharts
- KPI calculations
- Filtering, sorting, and conditional formatting

---

## Tableau Dashboard

The final Tableau dashboard presents the major KPIs and business trends in an interactive format.

It includes:

- Revenue over time
- Revenue by product category
- Top products by revenue
- Revenue by sales channel
- Transactions by payment method
- Revenue by discount status
- Interactive Date, Category, Location, and Payment Method filters

### Dashboard Preview

<img width="1208" height="1011" alt="Retail Sales Analysis Tableau Dashboard" src="https://github.com/user-attachments/assets/d22c34a5-9b7e-46b4-9593-a5ddefd5b80b" />


---

## Key Insights

### Online and In-Store Sales Were Closely Balanced
Online sales generated approximately **$749.4K**, compared with **$723.6K** in-store. Online also recorded slightly more transactions (5,745 vs. 5,617), helping explain its modest revenue lead.

### Revenue Remained Relatively Stable
Across complete months, revenue generally remained around **$35K–$46K**, without a clear sustained upward or downward trend. The January 2025 decline represents only a partial month because the dataset ends January 18.

### Revenue Was Diversified Across Categories
Revenue was distributed relatively evenly across product categories rather than being heavily dependent on a single category.

### Discount Results Require Caution
Revenue was relatively similar across discount groups, but **3,783 transactions had missing discount information**. Because of this missing data, stronger conclusions about discount effectiveness would require additional information.

---

## Project Structure

```text
Retail-Sales-Analysis/
├── data/
│   ├── retail_store_sales.csv
│   └── retail_sales_cleaned.csv
├── excel/
│   └── retail_sales_cleaned.xlsx
├── sql/
│   ├── data_inspection.sql
│   ├── data_cleaning.sql
│   ├── data_exploration.sql
│   └── data_analysis.sql
├── tableau/
│   └── retail_sales_dashboard.twbx
├── images/
│   └── retail_sales_dashboard.png
└── README.md
```

## Project Summary

This project demonstrates my ability to take raw business data through the complete analytics process: **cleaning and analyzing data with SQL, performing spreadsheet analysis in Excel, and communicating results through an interactive Tableau dashboard.**
