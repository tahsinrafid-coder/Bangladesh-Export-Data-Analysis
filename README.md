# Bangladesh Apparel Export Data Analysis

Bangladesh is a globally recognized leader in the apparel export sector. While organizations track knit and woven export data from a high-level business perspective, finding clean, centralized raw data for deeper analysis is a massive challenge.

This repository marks my first major milestone as I transition into a **Data Analyst** role. What I initially thought would be a straightforward project turned out to be an excellent, real-world lesson in data engineering!

---

## 🎯 Business Objective
This project transforms raw, unstructured data from the Export Promotion Bureau (EPB) into actionable insights. By analyzing a decade of historical export trends, this pipeline can be used to optimize supply chain logistics, forecast woven versus knit demands, and drive strategic sales and marketing decisions when managing key accounts for global buyers like GU and UNIQLO.

## 🛠️ Tech Stack
* **Python:** `pandas`, `glob`, `os` (Data Extraction, Transformation, and Cleaning)
* **PostgreSQL:** (Data Warehousing, Advanced Aggregation, Window Functions)
* **Power BI:** (Coming Soon: Data Visualization and Dashboarding)

## 📂 Data Sources & Challenges
* **The Hunt:** Finding public data required extensive research. I ultimately gathered the data from the [Export Promotion Bureau (EPB)](https://epb.gov.bd/).
* **The Reality:** The source files were incredibly messy, unformatted, and poorly structured—making them impossible to analyze right out of the box. 
* **Raw Data:** You can view the original, unaltered datasets in the [raw source files](link-to-your-folder) directory.

## 🏗️ Architecture & Pipeline Workflow
To transform this chaotic data into a usable format, I built a structured ETL (Extract, Transform, Load) pipeline:

1. **Extract & Clean (Python):** Developed scripts to handle regex filtering, forward-fill missing country codes, extract 6-digit HS codes, and standardize numeric values.
2. **Transform & Aggregate (Python):** Consolidated individual fiscal year CSV files by dynamically extracting and appending the corresponding **Fiscal Year** from the filenames.
3. **Load (PostgreSQL):** Imported the unified dataset into a relational database schema. 
4. **Analysis (SQL):** Engineered views to calculate YoY (Year-over-Year) growth, CAGR (Compound Annual Growth Rate), and total category contributions (Woven vs. Knit).

## 🚀 Key Insights (In Progress)
* *Will be updated once the SQL analysis is finalized and the Power BI dashboard is deployed.*
