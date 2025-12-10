use da_carburator_project;
show tables;
-- contract table
desc contract;
select * from contract;

# Handling Dates
/* dates are in mm/dd/yyyy form 
which is not in standard form 
so we need to make it correct in yyyy-mm-dd form*/
select distinct(ContractStartDate) from contract;

/* SUBSTRING_INDEX(string, delimiter, count)
string → column or text
delimiter → character(s) to split on
count :
	positive → take part before the delimiter
	negative → take part after the delimiter
    */
 -- finding date format
select count(distinct(substring_index(ContractStartDate,'/',1))) from contract; -- first part
select count(distinct(substring_index(ContractStartDate,'/',-1))) from contract; -- last part
select count(distinct(substring_index(substring_index(ContractStartDate,'/',2),'/',-1))) from contract; -- middle part

-- mm/dd/yyyy

select distinct(substring_index(ContractStartDate,'/',1)) from contract; -- first part
select distinct(substring_index(ContractStartDate,'/',-1)) from contract; -- last part
select distinct(substring_index(substring_index(ContractStartDate,'/',2),'/',-1)) from contract; -- middle part

start transaction;
set sql_safe_updates = 0;
update contract
set ContractStartDate = str_to_date(ContractStartDate,'%m/%d/%Y'),
ContractEndDate = str_to_date(ContractEndDate,'%m/%d/%Y');
commit;

select * from contract;

# alter type 

alter table contract
modify column FacilityId varchar(20) not null,
modify column SuplierId varchar(20) not null,
modify column ContractStartDate date not null,
modify column ContractEndDate date not null;

desc contract;

show tables;
# facility table
desc facility;
select * from facility;

select max(length(FacilityId)) as facilityid,
max(length(ManufacturerId)) as manufacturerid,
max(length(FacilityType)) as facilitytype,
max(length(Country)) as country,
max(length(City)) as city
from facility;

alter table facility
modify column FacilityId varchar(20) not null,
modify column ManufacturerId int not null,
modify column FacilityType varchar(30) not null,
modify column Country varchar(20) not null,
modify column City varchar(50) not null;

desc facility;

show tables;

desc manufacturer;

select max(length(ManufacturerId)) as ManufacturerId,
max(length(Name)) as Name,
max(length(HeadQuarters)) as HeadQuarters,
max(length(Manufacturer_Category)) as Manufacturer_Category
from manufacturer;

alter table manufacturer
modify column ManufacturerId int not null,
modify column Name  varchar(30) not null,
modify column HeadQuarters varchar(20) not null,
modify column Manufacturer_Category varchar(20) not null;

desc manufacturer;

show tables;

# production table
desc production;
select * from production limit 5;

select max(length(FacilityId)) as facilityid, # 6
max(length(Certification)) as Certification, # 11
max(length(Automation_Level)) as Automation_Level # 6
from production;

select * from production limit 5;

select max(length(Capacity_Utilization)) as Capacity_Utilization, # 6
max(length(Automation_Factor)) as Automation_Factor # 4
from production;

desc production;

select max(length(Capacity)) as Capacity, # 6
max(length(Production)) as Production, # 6
max(length(Employee_Count)) as Employee_Count # 5
from production;

select * from production limit 5;
desc production;

alter table production
modify column `Date` date not null,
modify column FacilityId  varchar(10) not null,
modify column Certification varchar(20) not null,
modify column Automation_Level varchar(10) not null,
modify column Capacity int not null,
modify column Production int not null,
modify column Capacity_Utilization decimal(8,4) not null,
modify column Automation_Factor decimal(8,4) not null,
modify column Employee_Count int not null;
desc production;

select * from production;

show tables;
desc suplier;
select * from suplier;

select max(length(MaterialName)) as MaterialName, # 61
max(length(Quality)) as Quality, # 10
max(length(SuplierCountry)) as SuplierCountry # 12
from suplier;
desc  suplier;

alter table suplier
modify column SuplierId int not null,
modify column MaterialName  varchar(100) not null,
modify column Quality varchar(20) not null,
modify column SuplierCountry varchar(20) not null;

