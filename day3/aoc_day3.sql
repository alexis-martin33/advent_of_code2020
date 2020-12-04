create table public.day3_input(
input varchar
);

copy public.day3_input 
from '/path/to/input.csv'
delimiter ',' csv;

-- Part 1
select count(*) from (
	select case when squarenum = 1 then '.'
	when mod(squarenum, 31) = 0 then substring(input from 31 for 1)
	else substring(input from mod(squarenum, 31)::INTEGER for 1) 
	end as tree_or_not
	from (
		select input,
				(ROW_NUMBER() over () *3 )-2 as squarenum
		from day3_input) as alias) as alias_2
where tree_or_not = '#';

-- part 2:
select sum(case when tree_or_not_route_1 = '#' then 1 else 0 end) *
sum(case when tree_or_not_route_2 = '#' then 1 else 0 end)*
sum(case when tree_or_not_route_3 = '#' then 1 else 0 end)*
sum(case when tree_or_not_route_4 = '#' then 1 else 0 end)*
sum(case when tree_or_not_route_5 = '#' then 1 else 0 end) 
from(
	select case when squarenum_route_1 = 1 then '.'
		when mod(squarenum_route_1, 31) = 0 then substring(input from 31 for 1)
		else substring(input from mod(squarenum_route_1, 31)::INTEGER for 1) 
		end as tree_or_not_route_1,
		case when squarenum_route_2 = 1 then '.'
		when mod(squarenum_route_2, 31) = 0 then substring(input from 31 for 1)
		else substring(input from mod(squarenum_route_2, 31)::INTEGER for 1) 
		end as tree_or_not_route_2,
			case when squarenum_route_3 = 1 then '.'
		when mod(squarenum_route_3, 31) = 0 then substring(input from 31 for 1)
		else substring(input from mod(squarenum_route_3, 31)::INTEGER for 1) 
		end as tree_or_not_route_3,
			case when squarenum_route_4 = 1 then '.'
		when mod(squarenum_route_4, 31) = 0 then substring(input from 31 for 1)
		else substring(input from mod(squarenum_route_4, 31)::INTEGER for 1) 
		end as tree_or_not_route_4,
			case when squarenum_route_5 = 1 then '.'
-- For route 5, we need to make sure to ignore those rows we skip, which would land on half-tiles
		when round(squarenum_route_5,0) != squarenum_route_5 then '.'
		when mod(squarenum_route_5, 31) = 0 then substring(input from 31 for 1)
		else substring(input from mod(squarenum_route_5, 31)::INTEGER for 1) 
		end as tree_or_not_route_5
		from (
			select input,
			-- The square on which we land is determined by the function 3*#movementsright - #movementsright -1
			--  For route 5, we move 0.5 squares right for each 1 down we do.
			row_number() over () as squarenum_route_1,
			(ROW_NUMBER() over () *3 )-2 as squarenum_route_2,
			(row_number() over () *5)-4 as squarenum_route_3,
			(row_number() over () *7)-6 as squarenum_route_4,
			(row_number() over () *0.5)+0.5 as squarenum_route_5
			from day3_input) as alias) as alias_2;