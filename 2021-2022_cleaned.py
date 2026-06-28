#import pandas and read the csv file, drop the first 4 rows and reset the index
import pandas as pd
df = pd.read_csv(r"D:\BD_apparel_export_project\Fiscal year wise source file\2021-2022.csv",encoding="latin1", dtype=str)
df = df.drop([0, 1, 2, 3])
df = df.reset_index(drop=True)

#Replace the column names with "Country", "description", and "Value"
df.columns = ["Country","description","Value"]    

#Nan value were replaced with the previous value in the "country" column using forward fill method
df["Country"] = df["Country"].ffill()

#Remove the country code and the colon from the "Country" column
df["Country"] = df["Country"].str.replace(
    r"^[A-Z]{2}:\s*",
    "",
    regex=True
)

#Filter the rows where the "description" column starts with 6 digits followed by a colon and create a copy of the filtered dataframe
df = df[
    df["description"].str.match(r"^\d{6}:", na=False)
].copy()
#Extract the 6 digit HS code from the "description" column and create a new column "HS_Code"
df["HS_Code"] = df["description"].str.extract(r"^(\d{6})")

#Remove the 6 digits HS code and the colon from the "description" column and create a new column "Product"
df["Product"] = df["description"].str.replace(
    r"^\d{6}:\s*",
    "",
    regex=True
)


#Select the relevant columns "Country", "HS_Code", "Product", and "Value" to create the final dataframe
final_df = df[
    ["Country", "HS_Code", "Product", "Value"]
]


#Remove the commas from the "Value" column and convert it to numeric type, coercing errors to NaN
df['Value'] = pd.to_numeric(df['Value'].astype(str).str.replace(',', ''), errors='coerce')

final_df.to_csv('2021-2022_cleaned.csv', index=False)   

#Print the first 20 rows of the final dataframe
print(final_df.head(20))
