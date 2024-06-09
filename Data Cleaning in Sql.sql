-- Data Cleaning
SELECT *
FROM world_layoffs.layoffs;

-- 1. Removing the duplicate data
-- 2. Standardise the data
-- 3. Checking null and blanks
-- 4. Removing the unnecessary data/column


-- 1. Removing the duplicate data
create table layoffs_staging 
like layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT * 
FROM layoffs;



-- Removing the duplicates
select *, 
row_number() over(partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;


with duplicate_cte AS
(
select *, 
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
select * from duplicate_cte
where row_num > 1;

select * from layoffs_staging
where company = 'Casper';





with duplicate_cte AS
(
select *, 
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging
)
delete 
from duplicate_cte
where row_num > 1;



create table layoffs_staging2 (
company text, 
location text, 
industry text, 
total_laid_off int default null, 
percentage_laid_off text, 
`date` text, 
stage text, 
country text, 
funds_raised_millions int default null, 
`row_num` int)
engine=InnoDB default charset=utf8mb4 collate=utf8mb4_0900_ai_ci; 


SELECT *
FROM layoffs_staging2;

insert into layoffs_staging2
select *, 
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) as row_num
from layoffs_staging;

set sql_safe_updates = 0;

SELECT *
FROM layoffs_staging2
where row_num > 1;


Delete
FROM layoffs_staging2
where row_num > 1;

SELECT *
FROM layoffs_staging2;


-- 2. Standadrise the data and fixing the issues

select company,  (trim(company)) from 
layoffs_staging2;

update layoffs_staging2
set company = trim(company);


select *  from 
layoffs_staging2
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto' 
where industry like 'Crypto%';

select distinct industry from layoffs_staging2;


select distinct country, trim(trailing '.' from country)
from 
layoffs_staging2
order by 1;

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';



-- to convert the date datatype from the text
select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_staging2;

update layoffs_staging2
set `date` = str_to_date(`date`, '%m/%d/%Y');

select `date` from layoffs_staging2;

-- to change the datatype
alter table layoffs_staging2
modify column `date` DATE;

select * 
from layoffs_staging2;



-- 3. Dealing with the nulls and blank
-- in order to find the null
select * from 
layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * 
from 
layoffs_staging2
where industry is null or industry = '';

select *
from 
layoffs_staging2
where company = 'Airbnb';

select t1.industry, t2.industry
from layoffs_staging2 as t1
join layoffs_staging2 as t2
on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

update layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;

update layoffs_staging2
set industry = null
where industry = '';

select * from layoffs_staging2
where company like 'Bally%';


select * from layoffs_staging2;


select * from 
layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete from 
layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select * from layoffs_staging2;


-- 4. Removing the unnecessary columns

alter table layoffs_staging2
drop column row_num;