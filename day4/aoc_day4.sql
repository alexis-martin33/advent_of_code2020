create table public.day4_input(
input varchar
);
-- For this problem I had to paste special the data into the CSV in order to show null rows, these will be useful 
--   to format the data into separated passports (I'm trying to do minimal manipulations outside of SQL)
copy public.day4_input 
from '/path/to/input.txt'
delimiter ',';

-- Part 1
-- If I had every passport entry on one line, it would be very easy to count the number of fields by counting # of colons

-- First I need to format the input so I can group each passport together, they are separated by null values
--   I will add a null row at the very start of the dataset
--   Then give each row a row number, and create a table of only the row numbers of null rows
--   These will be joined to the original table (without nulls) based on original_row_number > null_row_number
--   I will group these results by input, max(null_row_number) to obtain a number assigned to each passport

-- Step 1: Formatting the input
with 
day4_input_2 as ( 
select null as input
union all
select * from day4_input
),
--
rownum_table as (
select row_number() over() as rownum, case when input = '' then null else input end as input
from day4_input_2
),
--
rownum_null_table as (
select rownum as rownum_null from (
	select * from rownum_table
	) as alias
where input is null),
--
to_group as (
select * 
from rownum_table
left join rownum_null_table on rownum_table.rownum > rownum_null_table.rownum_null
where input is not null),
--
to_listagg as (
select rownum, input, max(rownum_null) as passport
from to_group 
group by 1,2
)
--step 2
select count(*) from (
	select char_length(fields) - char_length(replace(fields, ':', '')) as count_fields, * from (
		select string_agg(input, ' ') as fields, passport 
		from to_listagg
		group by passport) as alias) as alias_2
where (count_fields = 8) or (count_fields = 7 and fields not LIKE '%cid:%');



-- part 2: I just have to add conditions to my where clause from part 1
with 
day4_input_2 as ( 
select null as input
union all
select * from day4_input
),
--
rownum_table as (
select row_number() over() as rownum, case when input = '' then null else input end as input
from day4_input_2
),
--
rownum_null_table as (
select rownum as rownum_null from (
	select * from rownum_table
	) as alias
where input is null),
--
to_group as (
select * 
from rownum_table
left join rownum_null_table on rownum_table.rownum > rownum_null_table.rownum_null
where input is not null),
--
to_listagg as (
select rownum, input, max(rownum_null) as passport
from to_group 
group by 1,2
)
-- part 2
select count(*) from (
	select  
	substring(substring(fields from position('byr:' in fields)+4) from 1 for position(' ' in substring(fields from position('byr:' in fields)+4))-1)as byr,
	substring(substring(fields from position('iyr:' in fields)+4) from 1 for position(' ' in substring(fields from position('iyr:' in fields)+4))-1) as iyr,
	substring(substring(fields from position('eyr:' in fields)+4) from 1 for position(' ' in substring(fields from position('eyr:' in fields)+4))-1) as eyr,
	substring(substring(fields from position('hgt:' in fields)+4) from 1 for position(' ' in substring(fields from position('hgt:' in fields)+4))-1) as hgt,
	substring(substring(fields from position('hcl:' in fields)+4) from 1 for position(' ' in substring(fields from position('hcl:' in fields)+4))-1) as hcl,
	substring(substring(fields from position('ecl:' in fields)+4) from 1 for position(' ' in substring(fields from position('ecl:' in fields)+4))-1) as ecl,
	substring(substring(fields from position('pid:' in fields)+4) from 1 for position(' ' in substring(fields from position('pid:' in fields)+4))-1) as pid
	from (
		select char_length(fields) - char_length(replace(fields, ':', '')) as count_fields, * from (
			select string_agg(input, ' ') || ' ' as fields, passport 
			from to_listagg
			group by passport) as alias) as alias_2
	where
	--part 1 conditions
	(count_fields = 8) or (count_fields = 7 and fields not LIKE '%cid:%')) as alias_3
	where 
	byr::INTEGER >= 1920 and byr::INTEGER <= 2002
	and iyr::INTEGER >= 2010 and iyr::INTEGER <= 2020
	and substring(eyr from 1)::INTEGER >= 2020 and substring(eyr from 1)::INTEGER <= 2030
	and 1 = case when right(hgt, 2) = 'cm' and rtrim(hgt, 'cm')::INTEGER >= 150 and rtrim(hgt, 'cm')::INTEGER <= 193 then 1 
				 when right(hgt,2) = 'in' and rtrim(hgt, 'in')::INTEGER >= 59 and rtrim(hgt, 'in')::INTEGER <= 76 then 1 
				 else 0 end
	and substring(hcl from 1 for 1) = '#' and length(substring(hcl from 2)) = 6
	and ecl in ('amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth')
	and length(pid) = 9
	;










--step 2
select count(*) from (
	select char_length(fields) - char_length(replace(fields, ':', '')) as count_fields, * from (
		select string_agg(input, ' ') as fields, passport 
		from to_listagg
		group by passport) as alias) as alias_2
where
--part 1 conditions
(count_fields = 8) or (count_fields = 7 and fields not LIKE '%cid:%')
--part 2 conditions
and 
;
