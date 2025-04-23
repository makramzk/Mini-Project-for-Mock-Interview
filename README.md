# 📊 GlobalMart Sales Dashboard – Databricks Mini Project

Welcome to my **Business Intelligence mini project**, where I built a **Sales Dashboard** using **Databricks**. This project demonstrates my ability to transform raw data into interactive, insightful visualizations and KPIs that support strategic business decisions.

---

## 🧠 Introduction

In the world of **Business Intelligence (BI)**, practical hands-on exercises are key to developing true analytical skills. Dashboards serve as an essential tool for visualizing data, tracking **Key Performance Indicators (KPIs)**, and uncovering hidden trends to help businesses make informed, data-driven decisions.

This project leverages **Databricks** — a unified platform for data engineering and analytics — to process and visualize sales data for **GlobalMart**, a fictional retail company.

---

## 🎯 Project Objective

> **Goal**: Design and develop an interactive sales dashboard for GlobalMart to monitor total revenue, sales distribution by region, top-performing products, and overall trends.

The dashboard provides stakeholders with a clear view of the company’s sales performance and highlights areas of opportunity or concern.

---

## 📂 Project Tasks & Workflow

### ✅ Task 1: Environment Setup
- Logged into Databricks Workspace
- Created a new Python/SQL notebook
- Uploaded a CSV file containing sample sales data
- Registered the uploaded file as a Databricks table for querying

---

### 🧹 Task 2: Data Exploration & Cleaning
- Previewed dataset using SQL
- Checked for missing or null values
- Casted appropriate data types (e.g., `ORDERDATE` → `DATE`)
- Removed duplicates using SQL and DataFrame methods
- Computed basic descriptive statistics (mean, min, max, count)

---

### 📊 Task 3: Key Sales Metrics
Calculated the following metrics using SQL queries:

| Metric | Description |
|--------|-------------|
| 💰 Total Sales Revenue | `SUM(SALES)` |
| 📦 Number of Orders | `COUNT(DISTINCT ORDERNUMBER)` |
| 💵 Average Order Value | `SUM(SALES) / COUNT(DISTINCT ORDERNUMBER)` |
| 📈 Sales Trend | Aggregated monthly and quarterly trends |
| 🥇 Top Orders | Orders ranked by total revenue |

---

### 📈 Task 4: Visualizations & Dashboard Creation
Created visual widgets in Databricks Dashboards:

- **KPI Widgets**:
  - Total Sales
  - Number of Orders
  - Average Order Value
- **Line Chart**:
  - Sales trend over time (Month & Year)
- **Bar Chart**:
  - Top N orders by revenue

Each chart is based on SQL queries connected directly to the sales table.

---

### 🧩 Task 5: Dashboard Design
- Organized layout with prominent KPIs at the top
- Grouped charts for logical flow
- Added markdown headers to label sections
- Integrated **filters** for dynamic user interaction

---

### ✅ Task 6: Final Review
- Ensured accuracy and clarity of all metrics and charts
- Validated dashboard interactivity and layout
- Saved final dashboard for stakeholder access

---

## 💡 Tools & Technologies

| Tool | Purpose |
|------|---------|
| 🔷 Databricks | Data processing, SQL analytics, dashboard creation |
| 🐍 Python / SQL | Data cleaning & transformation |
| 📊 Databricks Dashboards | Interactive visualizations |
| 📁 CSV Dataset | Source sales data |

---

## 📸 Dashboard Preview

> _Dashbaord Click [here](https://github.com/makramzk/Mini-Project-for-Mock-Interview/blob/e9eeeda9baef9c19aeb4828ee9d61e040b5adda8/Mini%20Project%20Dashboard.png)

---

## 🙋‍♀️ About Me

Hi! I'm [**Mohammad Akram Zaki**], a data enthusiast passionate about transforming numbers into stories. This project is part of my ongoing journey in **Business Intelligence** and **Data Analytics**.

- 🔗 [GitHub Portfolio](https://github.com/makramzk)
- 📫 Connect with me on [LinkedIn]([https://linkedin.com/in/m-akram-zaki])

---

## 📝 License

This project is intended for educational and portfolio purposes only.

---
