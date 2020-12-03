create table public.day1_input(
input integer
);

copy public.day1_input 
from '/path/to/file.csv'
delimiter ',' csv;

-- Solves Part 1
with input_table as (
	select input, 
		   ROW_NUMBER() over (order by input) as rownum 
	from day1_input)
select input_table_1.input * input_table_2.input
from input_table as input_table_1
left join input_table as input_table_2 
on input_table_1.rownum > input_table_2.rownum
where input_table_1.input + input_table_2.input = 2020
;

-- Solves Part 2
with input_table as (
	select input, 
		   ROW_NUMBER() over (order by input) as rownum 
	from day1_input)
select input_table_1.input * input_table_2.input
from input_table as input_table_1
left join input_table as input_table_2 
on input_table_1.rownum > input_table_2.rownum
left join input_table as input_table_3
on input_table_2.rownum > input_table_3.rownum
where input_table_1.input + input_table_2.INPUT + input_table_3.input = 2020
;