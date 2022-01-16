--Cleaning data in SQL


--Starting with the first table; Dailly Activity
select count(*)
from [dbo].[dailyActivity_merged$]

select *
from [dbo].[dailyActivity_merged$]

--checking for the Id's without Total steps and distance
select Id, ActivityDate, TotalSteps, TotalDistance 
from [dbo].[dailyActivity_merged$]
where TotalSteps< 1
group by Id, ActivityDate, TotalSteps, TotalDistance
order by 1, 2


Update dailyActivity_merged$
Set ActivityDate = Convert(date, ActivityDate, 101)

select *
from [dbo].[dailyActivity_merged$]



--Determining the highest TotalSteps
select Id, ActivityDate, count(TotalSteps), TotalDistance 
from [dbo].[dailyActivity_merged$]
where TotalSteps>30000
group by Id, ActivityDate, TotalSteps, TotalDistance
order by 1, 2

--creating a new column on the daily activity table
Alter Table [dbo].[dailyActivity_merged$]
ADD day_of_week nvarchar(50)
select *
from [dbo].[dailyActivity_merged$]

Update dailyActivity_merged$
SET day_of_week = DATENAME(DW, ActivityDate)

select *
from [dbo].[dailyActivity_merged$]

select count(*), ActivityDate
from [dbo].[dailyActivity_merged$]
where TotalDistance> 10
group by ActivityDate
order by 1, 2

--creating a new column on the daily activity table
Alter Table [dbo].[dailyActivity_merged$]
ADD total_mins_sleep int,
total_mins_bed int

--Joining the dailyActivity, dailyCalories, dailyIntensities and dailySteps 
Select dailyActivity_merged$.Calories, dailyCalories_merged$.Calories
from [dbo].[dailyActivity_merged$]
join [dbo].[dailyCalories_merged$]
on (dailyActivity_merged$.Id = dailyCalories_merged$.Id and dailyActivity_merged$.ActivityDate = dailyCalories_merged$.ActivityDay)

select *
from [dbo].[dailyActivity_merged$]

--changing the date format
ALTER TABLE weightLogInfo_merged$
ADD Day  Date
UPDATE weightLogInfo_merged$
SET Day = CAST(Date AS Date)

ALTER TABLE weightLogInfo_merged$
DROP COLUMN Date

UPDATE weightLogInfo_merged$
SET WeightKg=ROUND(WeightKg,2), WeightPounds=ROUND(WeightPounds,2), BMI=ROUND(BMI,1)


select *
from [dbo].[sleepDay_merged$]


--Updating the date format
Update [dbo].[sleepDay_merged$]
set SleepDay = convert(DATE, SleepDay, 101)

ALTER TABLE sleepDay_merged$
 ALTER COLUMN Id NUMERIC (18,0)

ALTER TABLE sleepDay_merged$
 ALTER COLUMN SleepDay DATE

ALTER TABLE sleepDay_merged$
 ALTER COLUMN TotalSleepRecords INT

ALTER TABLE sleepDay_merged$
 ALTER COLUMN TotalMinutesAsleep NUMERIC (18,0)

ALTER TABLE sleepDay_merged$
 ALTER COLUMN TotalTimeInBed NUMERIC (18,0)

 select *
 from [dbo].[sleepDay_merged$]

SELECT DISTINCT id,
	   COUNT(ActivityDate) 
FROM dailyActivity_merged$  
GROUP BY id
HAVING COUNT(ActivityDate) = 31 

--removing the users that do not check their track progress
WITH ActivityCTE AS(
	SELECT *,
		   COUNT(*) OVER( PARTITION BY id) ctn
	FROM dailyActivity_merged$
)
DELETE ActivityCTE
WHERE ctn <> 31

--Checking and removing null values from all the tables
--weightLogInfo
SELECT *
FROM weightLogInfo_merged$

ALTER TABLE weightLogInfo_merged$
DROP COLUMN Fat

ALTER TABLE weightLogInfo_merged$
 ALTER COLUMN Id NUMERIC (18,0)

ALTER TABLE weightLogInfo_merged$
 ALTER COLUMN "Day" DATE
 
ALTER TABLE weightLogInfo_merged$
 ALTER COLUMN WeightKg FLOAT

ALTER TABLE weightLogInfo_merged$
 ALTER COLUMN WeightPounds FLOAT

ALTER TABLE weightLogInfo_merged$
 ALTER COLUMN BMI FLOAT

ALTER TABLE weightLogInfo_merged$
 ALTER COLUMN LogId NUMERIC (18,0)
 SELECT * FROM weightLogInfo_merged$

--Combining the sleepday table into the daily activity table
UPDATE dailyActivity_merged$
Set total_mins_sleep = b.TotalMinutesAsleep,
total_mins_bed = b.TotalTimeInBed 
From [dbo].[dailyActivity_merged$] as a
Full Outer Join sleepDay_merged$ as b
on a.id = b.id and a.ActivityDate = b.SleepDay
 
select * 
from [dbo].[dailyActivity_merged$]
  
--Combining dailyActivity and weightLogInfo
select *
from [dbo].[dailyActivity_merged$]
 left join weightLogInfo_merged$
on (dailyActivity_merged$.Id = weightLogInfo_merged$.Id and dailyActivity_merged$.ActivityDate = weightLogInfo_merged$.Day)

select *
from [dbo].[dailyActivity_merged$]

--removing unused rows

alter table [dailyActivity_merged$]
drop column LoggedActivitiesDistance

select *
from [dbo].[dailyActivity_merged$]

--Combining dailySteps and dailyActivity
update dailySteps_merged$
set StepTotal = StepTotal 
select a.Id, a.TotalSteps, b.StepTotal
from dailyActivity_merged$ as a
full outer join dailySteps_merged$ as b
	on a.Id=b.Id
where a.TotalSteps <> b.StepTotal and a.ActivityDate = b.ActivityDay 

select *
from [dbo].[dailyActivity_merged$]