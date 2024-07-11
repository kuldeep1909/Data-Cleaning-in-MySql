-- Exploratory Data Analysis (EDA)

select * from layoffs_staging2;



select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select * 
from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;

select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select min(`date`), max(`date`)
from layoffs_staging2;


select industry,  sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;


select country,  sum(total_laid_off)
from layoffs_staging2
group by country
order by 2 desc;

select year(`date`),  sum(total_laid_off)
from layoffs_staging2
group by year(`date`)
order by 1 desc;

select stage,  sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select * 
from layoffs_staging2;

-- Rolling Sum 
select substring(`date`, 1, 7) as `Month` ,sum(total_laid_off)
from layoffs_staging2
where substring(`date`, 1, 7) IS NOT NULL
group by `Month`
order by 1
;

-- Rolloing total with CTE

WITH Rolling_total AS
(
select substring(`date`, 1, 7) as `Month` ,sum(total_laid_off) as Total_off
from layoffs_staging2
where substring(`date`, 1, 7) IS NOT NULL
group by `Month`
order by 1
)
select `Month` , Total_off,
sum(Total_off) over(order by `Month`) as Rolling_Total
from Rolling_total;



-- RAnking based on the total_laid off
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by 3 desc ;


WITH Company_year (Company, years, total_laid_off) AS
(
select company, year(`date`), sum(total_laid_off)
from layoffs_staging2
group by company,year(`date`)
order by 3 desc 
), Company_year_rank AS
(
select *, dense_rank() over(partition by years ORDER BY total_laid_off desc) as Ranking
from Company_year
where years is not null
)
select * 
from Company_year_rank
where Ranking <= 5
;












