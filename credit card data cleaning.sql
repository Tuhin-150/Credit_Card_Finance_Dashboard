CREATE TABLE cc_detail (
    Client_Num INT,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date VARCHAR(20),
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5)
);

-- here is a simple step-by-step guide to change the Week_Start_Date column from VARCHAR(20) to DATE in MySQL:

set sql_safe_updates = 0;
-- Create a backup:
CREATE TABLE your_table_backup AS SELECT * FROM cc_detail;
-- Add a new DATE column:
ALTER TABLE cc_detail ADD COLUMN new_week_start_date DATE;
-- Convert and copy data:
UPDATE cc_detail
SET new_week_start_date = STR_TO_DATE(Week_Start_Date, '%d-%m-%Y');
-- Drop the old VARCHAR column:
ALTER TABLE cc_detail DROP COLUMN Week_Start_Date;
-- Rename the new DATE column:
ALTER TABLE cc_detail CHANGE COLUMN new_week_start_date Week_Start_Date DATE;

-- you need to convert the date format from "d-m-Y" to "Y-m-d" before importing it. You can achieve this by using MySQL's STR_TO_DATE function during the import process.



-- 1.Create a staging table to temporarily hold the data from your CSV file. The Week_Start_Date will be stored as a VARCHAR to allow the import of the "d-m-Y" format.

CREATE TABLE staging_table (
    Client_Num INT,
    Card_Category VARCHAR(20),
    Annual_Fees INT,
    Activation_30_Days INT,
    Customer_Acq_Cost INT,
    Week_Start_Date VARCHAR(20),
    Week_Num VARCHAR(20),
    Qtr VARCHAR(10),
    current_year INT,
    Credit_Limit DECIMAL(10,2),
    Total_Revolving_Bal INT,
    Total_Trans_Amt INT,
    Total_Trans_Ct INT,
    Avg_Utilization_Ratio DECIMAL(10,3),
    Use_Chip VARCHAR(10),
    Exp_Type VARCHAR(50),
    Interest_Earned DECIMAL(10,3),
    Delinquent_Acc VARCHAR(5)
);

-- 2.Load data into the staging table:
-- 3.Convert and insert data into the main table:
INSERT INTO cc_detail (Week_Start_Date, Client_Num,Card_Category,Annual_Fees,Activation_30_Days,Customer_Acq_Cost,Week_Num,Qtr,current_year,
 Credit_Limit,Total_Revolving_Bal,Total_Trans_Amt,Total_Trans_Ct,Avg_Utilization_Ratio,Use_Chip,Exp_Type,Interest_Earned, Delinquent_Acc)
SELECT STR_TO_DATE(Week_Start_Date, '%d-%m-%Y'),Client_Num,Card_Category,Annual_Fees,Activation_30_Days,Customer_Acq_Cost,Week_Num,Qtr,current_year,
 Credit_Limit,Total_Revolving_Bal,Total_Trans_Amt,Total_Trans_Ct,Avg_Utilization_Ratio,Use_Chip,Exp_Type,Interest_Earned, Delinquent_Acc
FROM staging_table;

-- Verify the data:
SELECT * FROM cc_detail;

-- Clean up:
DROP TABLE staging_table;


CREATE TABLE cust_detail (
    Client_Num INT,
    Customer_Age INT,
    Gender VARCHAR(5),
    Dependent_Count INT,
    Education_Level VARCHAR(50),
    Marital_Status VARCHAR(20),
    State_cd VARCHAR(50),
    Zipcode VARCHAR(20),
    Car_Owner VARCHAR(5),
    House_Owner VARCHAR(5),
    Personal_Loan VARCHAR(5),
    Contact VARCHAR(50),
    Customer_Job VARCHAR(50),
    Income INT,
    Cust_Satisfaction_Score INT
);
