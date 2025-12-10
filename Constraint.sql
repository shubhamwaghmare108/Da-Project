use da_carburator_project;

show tables;
select * from facility;

alter table facility
add constraint pkey_Fac_id primary key(FacilityId);

select * from manufacturer;

alter table manufacturer
add constraint pkey_man_id primary key(ManufacturerId);

select * from suplier;

alter table suplier
add constraint pkey_sup_id primary key(SuplierId);

select * from production;
alter table production
add constraint fkey_fac_id foreign key (FacilityId) references facility(FacilityId);
desc facility;
select distinct(FacilityId) from facility;
select distinct(FacilityId) from production;
    
select * from production;
select * from facility;
desc production;
desc facility;

alter table production
modify column FacilityId varchar(20) not null;

alter table production
add constraint fkey_fac_id foreign key (FacilityId) references facility(FacilityId);

start transaction;
update production
set FacilityId =  trim(FacilityId);
select * from production;
select distinct FacilityId from production;
commit;

start transaction;
update facility
set FacilityId =  trim(FacilityId);
select * from facility;
select distinct FacilityId from facility;
commit;

alter table production
add constraint foreign key (FacilityId) references facility(FacilityId);
desc production;

select * from facility as f
join production as p
on f.FacilityId = p.FacilityId;

select distinct facilityid from facility
union
select distinct facilityid from production;

START TRANSACTION;

UPDATE production
SET FacilityId = CONCAT(
    'FAC', 
    LPAD(
        -- 1. Extract the numeric part (e.g., '001' from 'FAC001')
        SUBSTRING(FacilityId, 4), 
        4, -- 2. Pad it to a length of 4
        '0'
    )
)
-- Target only the incorrectly formatted 6-character IDs (like 'FAC001')
WHERE LENGTH(FacilityId) = 6 AND FacilityId LIKE 'FAC%';
select distinct FacilityId from production;
COMMIT;
alter table production
add constraint foreign key (FacilityId) references facility(FacilityId);

show tables;
desc contract;
desc suplier;
alter table contract
add constraint foreign key (FacilityId) references facility(FacilityId);

alter table contract
modify column SuplierId int;

select * from contract limit 1 offset 97;

select * from contract where SuplierId ="";
start transaction;
select * from contract where SuplierId ="";
delete from contract where  SuplierId ="";
commit;

alter table contract
modify column SuplierId int;

alter table contract
add constraint foreign key (SuplierId) references suplier(SuplierId);

show tables;
desc contract;
desc facility;
desc manufacturer;
alter table facility
add constraint foreign key (ManufacturerId) references manufacturer(ManufacturerId);

desc production;
desc suplier;
