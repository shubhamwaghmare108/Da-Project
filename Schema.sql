Create database da_carburator_project;

use da_carburator_project;

create table manufacturer(
ManufacturerId text,
`Name`	text,
HeadQuarters text,
Manufacturer_Category text);

create table facility(
FacilityId text,
ManufacturerId	text,
FacilityType text,
Country	text,
City text);

create table suplier(
SuplierId	text,
MaterialName	text,
Quality	text,
SuplierCountry text);

create table production(
`Date` text,
FacilityId text,
Certification text,
Automation_Level text,
Capacity text,
Production text,
Capacity_Utilization text,
Automation_Factor text,
Employee_Count text);

create table contract(
FacilityId text,
SuplierId text,
ContractStartDate text,
ContractEndDate text);

