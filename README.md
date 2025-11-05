# Olist E-commerce: Logistics & QA Analysis (Google Data Analytics Capstone)

### [View the Interactive Dashboard on Tableau Public](https://public.tableau.com/views/OlistE-commerceAnalysisImpactofLogisticsandSellerQAonCustomerSatisfaction/Dashboard1?:language=es-ES&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

---

### Table of Contents
* [Project Objective](#project-objective)
* [Tools Used](#tools-used)
* [The 6 Phases of Analysis](#the-6-phases-of-analysis)
* [Key Findings & Recommendations](#key-findings--recommendations)
* [Repository Contents](#repository-contents)

---

## Project Objective

This analysis was commissioned to investigate the root cause of a high volume of 1-and-2-star customer reviews on the Olist e-commerce platform. The primary business hypothesis was that **poor logistics performance**—specifically, long delivery times—was the main driver of customer dissatisfaction.

This analysis confirms the hypothesis is correct and provides actionable recommendations.

---

## Tools Used

* **Database:** Microsoft SQL Server (for analysis)
* **Data Cleaning:** Advanced Excel (Power Query)
* **Statistical Analysis:** R (for correlation testing)
* **Visualization:** Tableau Public (for the final dashboard)
* **Other:** Google Drive, GitHub

---

## The 6 Phases of Analysis
*(The Google Data Analytics Process)*

This project followed the 6-phase data analysis process taught in the Google Data Analytics Professional Certificate.

### 1. ASK
The primary business task was to identify the drivers of low customer review scores. The key questions were:
* What is the correlation between delivery time and review score?
* Do late deliveries always result in bad reviews?
* Are there specific geographic regions or sellers that are underperforming?

### 2. PREPARE
Data was sourced from the public Olist E-Commerce dataset on Kaggle, which consists of 9 separate `.csv` files (e.g., `orders`, `reviews`, `sellers`, `customers`).

### 3. PROCESS
This phase involved multiple tools due to the complexity of the data:
* **Advanced Excel (Power Query):** The initial data was difficult to clean. We used Power Query's transformation tools to pre-process the files, handle complex `NULL` values, and format data before loading it into the database.
* **MS SQL Server:** After pre-processing, the clean data was loaded into a relational database with 9 tables. SQL was then used to convert data types (e.g., `text` to `datetime`) and perform feature engineering by adding new columns, such as `delivery_time_days` and `delivery_late`.

### 4. ANALYZE
Analysis was performed using both SQL and R:
* **SQL:** Wrote complex queries with multiple `JOINs` to create three main analysis tables:
    * `query1_logistics_vs_qa` (for the bar chart)
    * `query2_seller_performance` (for the scatter plot)
    * `query3_geographical_analysis` (for the maps)
* **R:** Performed a Pearson correlation test on the `query1` data to statistically validate the visual findings from Tableau.

### 5. SHARE
An interactive 4-quadrant dashboard was built in **Tableau Public** to present the findings to stakeholders. The dashboard integrates all four key analyses into a single, comprehensive story.

### 6. ACT
Based on the key findings, a 3-point action plan was developed for the Seller Management, Logistics, and Customer Experience teams.

---

## Key Findings & Recommendations

Our analysis revealed four key findings that led to three actionable recommendations.

### Key Findings

1.  **The Link is Statistically Proven:** A Pearson correlation test in R confirmed a **statistically significant, strong negative correlation (r = -0.976, p < 0.01)** between average delivery time and customer review score.
2.  **The Impact is Quantifiable:** 1-star reviews are associated with an average delivery time of **21.2 days**, whereas 5-star reviews are associated with an average of **10.6 days**.
3.  **Performance is Not Uniform by Region:** Geographic heatmaps clearly show that the North and Northeast regions of Brazil suffer from significantly longer delivery times, which directly results in lower average review scores.
4.  **A Specific Seller Group is Responsible:** The `Seller Performance Analysis` scatter plot identifies a "problem quadrant" of sellers who are both **slower than average (14.9 days)** and have **review scores lower than average (3.99 stars)**.

### Recommendations (The "Act" Phase)

1.  **(Action: Seller Management) Launch a Seller QA & Performance Program:**
    * Immediately engage the sellers identified in the "bottom-right" quadrant. These sellers require a formal process audit and retraining.

2.  **(Action: Logistics) Audit Regional Logistics Partners:**
    * Prioritize a performance review of the logistics carriers in the states identified by the maps as having the longest delivery times.

3.  **(Action: Customer Experience) Recalibrate Estimated Delivery Dates:**
    * Use the state-by-state delivery averages from this analysis to create a more realistic delivery estimation algorithm. This will manage customer expectations more effectively.

---

## Repository Contents

* **/SQL_Scripts/:** Contains all `.sql` files used for database analysis queries.
* **/R_Script/:** Contains the `.R` script used for the Pearson correlation test.
* **/Final_Report/:** (Optional) A PDF of the executive report.
