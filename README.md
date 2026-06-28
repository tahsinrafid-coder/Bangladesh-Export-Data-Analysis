```markdown
## 🏗️ Architecture & Pipeline Workflow

My data pipeline follows a structured **End-to-End ETL** pattern, transforming completely unformatted public reports into structured business metrics:

### 📥 1. Extract
> **Raw EPB Files** ➔ **Python (Pandas)**
* Handled unstructured text formatting using Python's `glob` and `os` libraries.
* Applied regular expressions (`regex`) to filter relevant rows and isolate target garment fields.

### ⚙️ 2. Transform
> **Data Standardizing** ➔ **Dynamic Merging**
* Executed data cleaning techniques like forward-filling missing country data and parsing 6-digit HS codes.
* Built a dynamic scripting step that read the raw filenames, extracted the corresponding *Fiscal Year*, and appended it to the records before compiling individual sheets into a single master file.

### 📤 3. Load
> **Unified File** ➔ **PostgreSQL Relational Storage**
* Migrated the compiled data into a data warehouse layer.
* Cleaned text formatting errors on the database side and safely cast string currency indicators (`TEXT`) into quantitative metrics (`NUMERIC`).

### 🔍 4. Analyze
> **SQL Queries** ➔ **Actionable Analytical Frameworks**
* **Segmentation:** Used conditional logic (`CASE WHEN`) to split messy item strings into definitive **Knit vs. Woven** market categories.
* **Trend Analysis:** Used advanced window functions (`LAG()`) to isolate pandemic-era dips and calculate exact **Year-over-Year (YoY) Growth %**.
* **Long-Term Performance:** Implemented analytical CTEs using `ROW_NUMBER()` to calculate **Compound Annual Growth Rates (CAGR)** across a decade of exports.

### 📊 5. Visualize (Coming Soon)
> **PostgreSQL Views** ➔ **Power BI Dashboard**
* Connecting saved SQL analysis views directly to Power BI to track brand market-shares, category demand peaks, and key account performances.
