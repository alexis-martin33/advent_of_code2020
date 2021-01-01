drop table day9_input;
create table public.day9_input(
input varchar,
input_id serial
);

copy public.day9_input (input) 
from '/path/to/input.txt'
;

-- part 1
select check_input,check_id, 
sum(case when check_input::BIGINT = sum_inputs  then 1 else 0 end) as count_stuff 
from (
	select another_table.input as check_input, 
	another_table.input_id as check_id,
	left_table.input as left_input,
	left_table.input_id as left_input_id,
	right_table.input as right_input,  
	right_table.input_id as right_input_id, 
	left_table.input::BIGINT + right_table.input::BIGINT as sum_inputs
	from day9_input as left_table
	left join day9_input as right_table 
		on right_table.input_id >= left_table.input_id + 1 
		and right_table.input_id <= left_table.input_id + 24
	left join day9_input as another_table 
		on another_table.input_id <= left_table.input_id + 25
		   and another_table.input_id > left_table.input_id
		   and another_table.input_id > 25
		   and another_table.input_id > right_table.input_id) as alias
group by 1,2 having(sum(case when check_input::BIGINT = sum_inputs  then 1 else 0 end) = 0)
order by check_id
;


-- part 2

