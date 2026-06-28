# Bangladesh Export Data Analysis

Bangladesh is a globally recognized leader in the apparel export sector. While organizations like the [BGMEA](https://www.bgmea.com.bd/) track knit and woven export data from a business perspective, finding clean, centralized raw data for deeper analysis is a massive challenge.

This repository marks my first major milestone as I transition into a **Data Analyst** role. What I initially thought would be a straightforward project turned out to be an excellent, real-world lesson in data engineering!

---

## 📂 Data Sources & Challenges
* **The Hunt:** Finding public data required extensive research. I ultimately gathered the data from the [Export Promotion Bureau (EPB)](https://epb.gov.bd/).
* **The Reality:** The source files were incredibly messy, unformatted, and poorly structured—making them impossible to analyze right out of the box. 
* **Raw Data:** You can view the original, unaltered datasets in the [raw source files](https://github.com/tahsinrafid-coder/Bangladesh-Export-Data-Analysis/tree/main/raw%20source%20files) directory.

## 🛠️ Data Pipeline & Cleaning Workflow
To transform this chaotic data into a usable format, I built a structured preprocessing pipeline:

1. **Python Data Cleaning:** I wrote a custom script, `clean_script.py`, to parse, clean, and standardize the messy raw files using Python.
2. **Data Aggregation:** I consolidated the separate datasets, organizing them systematically by **Fiscal Year**.
3. **Database Preparation:** Finally, I combined all fiscal year data into a single, unified master dataset, optimized and ready to be loaded into **SQL** for advanced querying and analysis.

