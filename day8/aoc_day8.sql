drop table day8_input;
create table public.day8_input(
input varchar,
input_id serial
);

copy public.day8_input (input) 
from '/path/to/input.txt'
;

-- part 1
with recursive default_table as (
	select substring(input from 1 for 3) as action, split_part(input, ' ', 2)::INTEGER as movement, input_id as page_number, 
		case when substring(input from 1 for 3) = 'acc' then split_part(input, ' ', 2)::INTEGER  else 0 end as accumulator,
		case when substring(input from 1 for 3) = 'jmp' then split_part(input, ' ', 2)::INTEGER  else 1 end as jump
	from day8_input),
--
this_action as (
	select action, movement, page_number, accumulator, jump
	from default_table 
	where page_number = 1
union 
	select next_action.action, next_action.movement, next_action.page_number, next_action.accumulator, next_action.jump
	from default_table as next_action
	inner join this_action on this_action.page_number + this_action.jump = next_action.page_number
	)
--
select sum(accumulator) as solution from this_action 
;

select substring(input from 1 for 3) as action, split_part(input, ' ', 2)::INTEGER as movement, input_id as page_number, 
		case when substring(input from 1 for 3) = 'acc' then split_part(input, ' ', 2)::INTEGER  else 0 end as accumulator,
		case when substring(input from 1 for 3) = 'jmp' then split_part(input, ' ', 2)::INTEGER  else 1 end as jump
	from day8_input; 


-- part 2
-- part 1
with recursive default_table as (
	select substring(input from 1 for 3) as action, split_part(input, ' ', 2)::INTEGER as movement, input_id as page_number, 
		case when substring(input from 1 for 3) = 'acc' then split_part(input, ' ', 2)::INTEGER  else 0 end as accumulator,
		case when substring(input from 1 for 3) = 'jmp' then split_part(input, ' ', 2)::INTEGER  else 1 end as jump
	from day8_input),
--
this_action as (
	select action, movement, page_number, accumulator, jump
	from default_table 
	where page_number = 1
union 
	select next_action.action, next_action.movement, next_action.page_number, next_action.accumulator, next_action.jump
	from default_table as next_action
	inner join this_action on this_action.page_number + this_action.jump = next_action.page_number
	)
--
select sum(accumulator) as solution from this_action 
;

select substring(input from 1 for 3) as action, split_part(input, ' ', 2)::INTEGER as movement, input_id as page_number, 
		case when substring(input from 1 for 3) = 'acc' then split_part(input, ' ', 2)::INTEGER  else 0 end as accumulator,
		case when substring(input from 1 for 3) = 'jmp' then split_part(input, ' ', 2)::INTEGER  else 1 end as jump
	from day8_input; 

