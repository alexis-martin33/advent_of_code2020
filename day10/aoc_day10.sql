drop table day10_input;
create table public.day10_input(
input varchar,
input_id serial
);

copy public.day10_input (input) 
from 'path_to/input.txt';

-- part 1

with day10_input_2 as (select input::int as jolt, input_id from day10_input where input != ''
),
day10_input_3 as (
select * from day10_input_2
union all 
select 0, min(input_id - 1) from day10_input_2
union all
select max(jolt) +3 as input, max(input_id) +1 as input_id from day10_input_2
)
--
-- There is no aggregate for multiplication in SQL, but we can aggregate a sum of natural logarithms, and then do e^(our_result) to obtain the multiplication 
 select EXP(SUM(ln(number_of))) from (
	select  difference, count(*) as number_of from (
		select jolt, jolt-lag(jolt,1) over (order by jolt) as difference, input_id from day10_input_3 order by jolt
		) as alias where difference is not null group by difference
)as alias_2;




