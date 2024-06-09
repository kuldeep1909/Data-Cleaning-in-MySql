
# SQL Data Cleaning Project
This project focuses on cleaning and preprocessing a dataset containing information about layoffs in various companies across different industries. The dataset is stored in a MySQL database table named layoffs_staging2.
Dataset Description
The layoffs_staging2 table has the following columns:

company: The name of the company.
location: The location of the company.
industry: The industry sector of the company.
total_laid_off: The total number of employees laid off.
percentage_laid_off: The percentage of employees laid off.
date: The date when the layoff occurred.
stage: The funding stage of the company.
country: The country where the company is based.
funds_raised_millions: The total funds raised by the company in millions.

Data Cleaning Process
The data cleaning process involved the following steps:

Removing Duplicate Data: Duplicates were identified based on a combination of columns (company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions). Duplicate rows were removed using a ROW_NUMBER() window function and DELETE statements.
Standardizing Data:

Trimmed leading and trailing spaces from the company column.
Standardized the industry column by replacing 'Crypto%' with 'Crypto'.
Trimmed trailing periods from the country column for entries like 'United States.'.
Converted the date column from text to the DATE data type using STR_TO_DATE() and ALTER TABLE statements.


Handling Nulls and Blanks:

Identified rows with null values in total_laid_off and percentage_laid_off columns and deleted them.
Replaced null values in the industry column with values from other rows with the same company using an UPDATE statement with a self-join.
Replaced blank strings with null values in the industry column.


Removing Unnecessary Columns: Dropped the row_num column, which was a temporary column used for deduplication.

Usage
You can use this cleaned dataset for further analysis, visualization, or machine learning tasks related to layoffs and company dynamics. The cleaned data is stored in the layoffs_staging2 table in the MySQL database.
Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.
