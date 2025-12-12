use da_carburator_project;
show tables;
select  * from manufacturer;
-- how many record are there in manufacturer table
select count(*) as records from manufacturer;

-- is there null values?
desc manufacturer;
-- no nulls as null suggest null not allowed

-- unique manufacturer count
select count(distinct manufacturerid) from manufacturer;

-- give name of manufacturer
select distinct name from manufacturer;

-- give distinct headqt
select distinct HeadQuarters from manufacturer;
select count(distinct HeadQuarters) from manufacturer;
desc manufacturer;

-- differet manufacturer category

select distinct manufacturer_category from manufacturer;
--------------------------------------------------------------------
/* There are 20 unique company operatin in 2 catogory
headquatered in 10 countries */
--------------------------------------------------------------------
show tables;
desc facility;
select * from facility limit 5;
-- distinct facility type
select distinct facilitytype from facility;
-- different region where they are located
select distinct Country from facility;
select count(distinct Country) from facility;

select distinct city from facility;
select count(distinct city) from facility;

-- number of production facility
select  count(*) as facility_count from facility;

---------------------------------------------------------------
/*
In facility table there is facility id as primary key.
manufacturer id is foregion key.
there are 20 manufacturer operating 137 facility across  15 country.
*/
------------------------------------------------------------------
show tables;
desc suplier;

-- disticnt quality grade
select distinct(quality) from suplier; -- 3 quality

-- distinct suplier country
select distinct(SuplierCountry) from suplier;
select count(distinct(SuplierCountry)) from suplier;-- 15 country

-- list of distinct material name;
select distinct(materialname) from suplier;
select count(distinct(materialname)) from suplier; -- 24 material
-- list count of different vendors for each material
select materialname,count(*) as vendor_count from suplier
group by materialname order by vendor_count desc;

-- count of material vendors by country
select supliercountry,count(*) as venders from suplier
group by supliercountry order by venders desc; -- spain has 12 vendors,south korea has 4.


select * from suplier where MaterialName = 'Adhesives and Joint Sealants';
-- duplicate identification
select *,row_number() 
over (partition by MaterialName,Quality,SuplierCountry) as supliernumber
from suplier;

-- what india suplies?
select * from suplier where SuplierCountry = 'India';
-- error resolution
select length(SuplierCountry) from suplier where suplierid= 1;
start transaction;
update suplier
set SuplierCountry = trim(SuplierCountry);
commit;

select * from suplier where SuplierCountry = 'India';
select * from suplier;
select length(SuplierCountry) from suplier where suplierid= 1;
SELECT SuplierCountry, HEX(SuplierCountry)
FROM suplier LIMIT 20;

start transaction;
UPDATE suplier
SET SuplierCountry = REPLACE(SuplierCountry, '\r', '');
commit;

select * from suplier;
select length(SuplierCountry) from suplier where suplierid= 1;

show tables;
select length(ContractEndDate) from contract where facilityid='fac0012' and suplierid=39;
select * from contract where facilityid='fac0012' and suplierid=39;
show tables;
select length(city) from facility where facilityid='fac0007' and manufacturerid=2;

select * from facility where city = "East Java";
start transaction;
set sql_safe_updates = 0;
UPDATE facility
SET city = REPLACE(city, '\r', '');
select length(city) from facility where facilityid='fac0007' and manufacturerid=2;
commit;

show tables;
select length(Manufacturer_category) from manufacturer;

start transaction;
set sql_safe_updates = 0;
UPDATE manufacturer
SET Manufacturer_category = REPLACE(Manufacturer_category, '\r', '');
select length(Manufacturer_category) from manufacturer;
commit;
show tables;
select * from production;
select * from production where employee_count = 2530;

--------------------------------------------------------------------------------
show tables;
desc contract;
select max(ContractStartDate) from contract; -- latest contract

select min(ContractStartDate) from contract; -- oldest contract

select max(ContractEndDate) from contract; -- latest contract

select min(ContractEndDate) from contract; -- oldest contract

-- longest peroid contract

select ContractEndDate,ContractStartDate,ContractEndDate -ContractStartDate from contract;

SELECT 
    *,
    DATEDIFF(ContractEndDate, ContractStartDate) AS DaysDifference
FROM contract;

SELECT 
    ContractEndDate,
    ContractStartDate,
    TIMESTAMPDIFF(MONTH, ContractStartDate, ContractEndDate) AS MonthsDifference
FROM contract;

SELECT 
    ContractEndDate,
    ContractStartDate,
    TIMESTAMPDIFF(YEAR, ContractStartDate, ContractEndDate) AS YearsDifference
FROM contract;

desc contract;

SELECT
    ContractStartDate,
    ContractEndDate,

    -- Years difference
    TIMESTAMPDIFF(YEAR, ContractStartDate, ContractEndDate) AS Years,

    -- Months difference (remaining after full years)
    TIMESTAMPDIFF(MONTH, ContractStartDate, ContractEndDate)
      - TIMESTAMPDIFF(YEAR, ContractStartDate, ContractEndDate) * 12 AS Months,

    -- Days difference (remaining after full months)
    DATEDIFF(
        ContractEndDate,
        DATE_ADD(
            ContractStartDate,
            INTERVAL TIMESTAMPDIFF(MONTH, ContractStartDate, ContractEndDate) MONTH
        )
    ) AS Days

FROM contract;

select * from suplier;

select * from suplier as s1 left join contract as c1 on S1.SuplierId=C1.SuplierId;

with suplier_cte as
(select c1.SuplierId from suplier as s1 right join contract as c1 on S1.SuplierId=C1.SuplierId)
select distinct suplierid from suplier_cte;

select count(distinct(suplierid)) from contract;-- there are 99 distinct supplier in contract
select count(suplierid) from contract;

select count(*) from suplier; -- there are 120 suplier in suplier table 

# so there are some suplier how are not suplying anything
-- let found it out
select s1.SuplierId from suplier as s1 left join contract as c1 on S1.SuplierId=C1.SuplierId
where c1.SuplierId is null;

SELECT suplierid
FROM suplier
WHERE suplierid NOT IN (SELECT distinct SuplierId FROM contract);

select * from contract;

-- records in tables
select "suplier" as table_name,count(*) as records from suplier
union
select "manufacturer" as table_name,count(*) as records from manufacturer
union
select "contract" as table_name,count(*) as records from contract
union 
select "facility" as table_name,count(*) as records from facility
union
select "production" as table_name,count(*) as records from production;
------------------------------------------------------------------------------
/*there are 21 suplier id which do not supply to any facility*/
------------------------------------------------------------------------------

desc production;
-- production data date range
select min(date) as oldest,max(date) as latest from production;

select count(distinct(facilityid)) from production;

select distinct(certification) from production;

-- which got no certification-- 36 in number
select count(distinct facilityid) from production where Certification = 'None';

-- where they are located
desc production;

select facilityid,city,country from facility
where facilityid in (select distinct facilityid from production where Certification = 'None');

-- who owns them
select m1.ManufacturerId,name,HeadQuarters,Manufacturer_Category,facilityid,city,country from manufacturer as m1
join (select facilityid,ManufacturerId,city,country from facility
where facilityid in (select distinct facilityid from production where Certification = 'None')) as p1
on m1.manufacturerid=p1.ManufacturerId;

--
select * from production;
select facilityid,max(date) from production
group by facilityid;

alter table facility
add column employee_count int;

with cte as (
SELECT p.facilityid, p.date, p.employee_count
FROM production p
JOIN (
  SELECT facilityid, MAX(date) AS max_date
  FROM production
  GROUP BY facilityid
) m ON p.facilityid = m.facilityid AND p.date = m.max_date)
select f.FacilityId,c.employee_count from facility as f join cte as c on f.FacilityId=c.FacilityId;

create view facility_employee_count as
with cte as (
SELECT p.facilityid, p.date, p.employee_count
FROM production p
JOIN (
  SELECT facilityid, MAX(date) AS max_date
  FROM production
  GROUP BY facilityid
) m ON p.facilityid = m.facilityid AND p.date = m.max_date)
select f.FacilityId,c.employee_count from facility as f join cte as c on f.FacilityId=c.FacilityId;


START TRANSACTION;
set sql_safe_updates = 0;
UPDATE facility f
JOIN (
  SELECT p.facilityid, p.employee_count
  FROM production p
  JOIN (
    SELECT facilityid, MAX(date) AS max_date
    FROM production
    GROUP BY facilityid
  ) m ON p.facilityid = m.facilityid AND p.date = m.max_date
) AS latest ON f.FacilityId = latest.FacilityId
SET f.employee_count = latest.employee_count;
select * from facility;
COMMIT;
 alter table manufacturer
 add column employee_count int;
 
START TRANSACTION;
set sql_safe_updates = 0;
UPDATE manufacturer m
JOIN (
	SELECT manufacturerid, sum(Employee_Count) AS total_employee
    FROM facility
    GROUP BY manufacturerid
  ) m1 ON m.manufacturerid = m1.manufacturerid
SET m.employee_count = m1.total_employee;
select employee_count from manufacturer where ManufacturerId=1;
SELECT manufacturerid, sum(Employee_Count) AS total_employee
    FROM facility
    GROUP BY manufacturerid
    having manufacturerid=1;
commit;

select * from manufacturer;
select * from facility;

select * from production;

DELIMITER $$

CREATE TRIGGER trg_update_facility_employee_count
AFTER INSERT ON production
FOR EACH ROW
BEGIN
    -- Update facility table with the latest employee_count for that facility
    UPDATE facility f
JOIN (
  SELECT p.facilityid, p.employee_count
  FROM production p
  JOIN (
    SELECT facilityid, MAX(date) AS max_date
    FROM production
    GROUP BY facilityid
  ) m ON p.facilityid = m.facilityid AND p.date = m.max_date
) AS latest ON f.FacilityId = latest.FacilityId
SET f.employee_count = latest.employee_count;
END$$

DELIMITER ;
select * from production;

DELIMITER $$

CREATE TRIGGER trg_update_manufacturer_employee_count
AFTER UPDATE ON facility
FOR EACH ROW
BEGIN
    -- Update manufacturer table with the NEW employee_count
    UPDATE manufacturer m
	JOIN (
	SELECT manufacturerid, sum(Employee_Count) AS total_employee
    FROM facility
    GROUP BY manufacturerid
	) m1 ON m.manufacturerid = m1.manufacturerid
	SET m.employee_count = m1.total_employee;
END$$

DELIMITER ;
select * from facility;
select * from manufacturer;
select * from production;

start transaction;
insert into production values(
	'2026-01-01'	,'FAC0137'	,'IATF' ,	'High'	,161621,	137502,	0.8508,	1.2000,	3300);
select * from facility where FacilityId='FAC0137';
select * from manufacturer where ManufacturerId=20;
rollback;
select * from facility where FacilityId='FAC0137';
start transaction;

update facility set employee_count= 13000
where facilityid = 'Fac0137';
select * from manufacturer where ManufacturerId=20;
rollback;

update facility set employee_count= 3240
where facilityid = 'Fac0137';

