# Bangladesh Apparel Export Data Analysis

Bangladesh is a globally recognized leader in the apparel export sector. But here's the reality: while everyone talks about our knit and woven exports, getting your hands on clean, centralized raw data to actually analyze is a massive headache. 

Coming from a background in textile sales and marketing—and managing accounts for global buyers—I know exactly how valuable this data is. So, as part of my transition into a Data Analyst role, I decided to build a solution myself. 

What I initially thought would be a quick project turned into a hard-fought, real-world lesson in data engineering!

## 🛠️ The Tools I Used
I built this entire process from scratch using:
* **VS Code:** My main environment for writing and debugging the Python scripts.
* **Python (`pandas`, `re`, `glob`):** To aggressively clean, parse, and combine a decade's worth of messy CSV files.
* **PostgreSQL:** My database of choice for writing the queries, aggregating the data, and running window functions.
* **Power BI:** (Coming soon for the dashboarding phase!)

## 📂 The Problem: Unusable Source Data
* **The Hunt:** I sourced the raw export data directly from the [Export Promotion Bureau (EPB)](https://epb.gov.bd/).
* **The Reality:** The source files spanning 2011 to 2025 were unformatted, wildly inconsistent, and impossible to query out of the box. (You can see just how chaotic the originals were in the [raw source files](link-to-folder) directory).

## 🏗️ How I Built the Pipeline
To get this data into a state where I could actually run queries on it, I had to build a structured workflow:

1. **Wrangling in Python:** I wrote a custom cleaning script in VS Code. I had to use regex to extract the 6-digit HS codes, forward-fill missing country codes, and standardize the numeric values so the database wouldn't reject them.
2. **Combining the Years:** Because every fiscal year was trapped in its own isolated file, I wrote a second script to loop through my directory, dynamically extract the fiscal year from the filename, and stack everything into one unified `combined_data.csv`.
3. **Loading into PostgreSQL:** With a clean master dataset ready, I designed a schema in PostgreSQL and imported everything.
4. **SQL Analysis:** Finally, I was able to write the queries I actually wanted to run. I used CTEs and window functions to calculate YoY growth, CAGR, and track the historical performance of Denim, Woven, and Knit categories.

## 🚀 What's Next
I'm currently writing more advanced SQL queries and will be connecting PostgreSQL to Power BI to build an interactive dashboard shortly.
