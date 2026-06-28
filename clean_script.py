#import pandas and read the csv file, drop the first 4 rows and reset the index
import pandas as pd
df = pd.read_csv(r"D:\BD_apparel_export_project\Fiscal year wise source file\2011-2012 Export Data.csv",encoding="latin1", dtype=str)
df = df.drop([0, 1, 2, 3])
df = df.reset_index(drop=True)

#Replace the column names with "description" and "value"
df.columns = ["description","value"]

#create a new column "country" and extract the country code from the "description" column using regex
df["Country"] = df["description"].where(
    df["description"].str.match(r"^[A-Z]{2}:")
)
#Nan value were replaced with the previous value in the "country" column using forward fill method
df["Country"] = df["Country"].ffill()

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

#Remove the country code and the colon from the "Country" column
df["Country"] = df["Country"].str.replace(
    r"^[A-Z]{2}:\s*",
    "",
    regex=True
)

#Remove the commas from the "value" column and convert it to numeric type, create a new column "Value"
df["Value"] = (
    df["value"]
    .astype(str)
    .str.replace(",", "", regex=False)
)

#Convert the "Value" column to numeric type, coercing errors to NaN
df["Value"] = pd.to_numeric(df["Value"], errors="coerce")

#Select the relevant columns "Country", "HS_Code", "Product", and "Value" to create the final dataframe
final_df = df[
    ["Country", "HS_Code", "Product", "Value"]
]

final_df.to_csv('2011_2012_cleaned.csv', index=False)

#Print the first 20 rows of the final dataframe
print(final_df.head(20))
