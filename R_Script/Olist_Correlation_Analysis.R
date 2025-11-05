# --- Step 1: Load Required Libraries ---
# (This step is correct)
library(readr)

# --- Step 2: Load Your Data (The Correct Way) ---
datos_query1 <- read.csv2(file.choose())
# We must use read_delim() for full control.
# We tell it:
# 1. The delimiter (separator) is a semicolon (;)
# 2. The decimal mark is a period (.)
datos_query1 <- read_delim(
  "Olist/query1_logistics_vs_qa.csv", delim = ";",
  locale = locale(decimal_mark = ".")
)

# --- Step 3: Inspect the Data (Verify the fix) ---
# NOW this print should show the correct decimals (e.g., 21.2, 16.63)
print(datos_query1)

# --- Step 4: Run the Statistical Analysis ---
# This will now run on the correct numbers
cor.test(~ review_score_int + avg_delivery_time_days, data = datos_query1)
