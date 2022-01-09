Select *
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
order by 3,4


-- Selecting data relevant for this project
select Area, Element, Item, Year, Value, Flag
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
order by 1,3

--Looking at all items for the pesticide use
select distinct Item
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
order by Item


--Looking at the types of item for the pesticide use
select Area, Item, Year, Value
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
where Item = 'Herbicides' or
      Item = 'Insecticides'
order by 1,2

--Looking at the types of item for the pesticide use; Herbicides
select count(*) Item
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
where Item = 'Herbicides' 

  --Looking at the types of item for the pesticide use; Insecticides
select count(*) Item
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
where Item = 'Insecticides'    


--Looking at the types of item for the pesticide use; Fungicides and Bactericides
select count(*) Item
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
where Item = 'Fungicides and Bactericides' 



---- looking at the highest value for pesticide use
select Area, Item, Year, Value
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
where Value > 10000


---- looking only at the countries with the highest pesticide use
select Area, max(Value)
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
Group by Area
order by 1,2


----Looking at the countries with the highest pesticide use
select Area, max(cast(Value as int)) as PesticideUseValue
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
Group by Area
order by PesticideUseValue DESC


-----looking deeper into the year
Select Area, Year, Value
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
where Year < 2021 


----creating view for visualization
Create View PesticideUseValue as 
select Area, max(cast(Value as int)) as PesticideUseValue
from [PesticideUse].[dbo].['FAOSTAT_data_1-9-2022$']
Group by Area
--order by PesticideUseValue DESC





-----Grouping Area in different continents
