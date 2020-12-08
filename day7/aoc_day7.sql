drop table day7_input;

create table public.day7_input(
input varchar,
input_id serial
);

copy public.day7_input (input) 
from '/path/to/input.txt'
;

-- Part 1 
with recursive proper_format as (
	select split_part(input, ' bags', 1) as outer_colour, split_part(input, ' bags contain', 2) as inner_colours 
	from day7_input
),
outer_bag as (
	select outer_colour, inner_colours
	from proper_format
	where position('shiny gold' in inner_colours) != 0
union 
	select inner_bags.outer_colour, inner_bags.inner_colours 
	from proper_format as inner_bags
	inner join outer_bag on position(outer_bag.outer_colour in inner_bags.inner_colours) != 0)
select count(*) from outer_bag;

-------------------------------------------------------------------------
-- part 2
-- how many bags fit in my shiny gold bag
-- leaving last 3 extra columns in the recursion to understand what happens better when I revisit
with recursive proper_format as (
	select split_part(input, ' bags', 1) as outer_colour, split_part(input, ' bags contain', 2) as inner_colours, 1 as bag_quantity
	from day7_input
),
outer_bag as (
	select outer_colour, inner_colours,null,null,0 ,bag_quantity, 0::bigint as unique_identifier
	from proper_format
	where outer_colour = 'shiny gold'
union 
	select inner_bags.outer_colour, inner_bags.inner_colours , outer_bag.outer_colour, outer_bag.inner_colours, outer_bag.bag_quantity,
	right(left(outer_bag.inner_colours, position(inner_bags.outer_colour in outer_bag.inner_colours) - 2),1)::INTEGER * outer_bag.bag_quantity as bag_quantity,
	row_number() over () as unique_identifier
	from proper_format as inner_bags
	inner join outer_bag on position(inner_bags.outer_colour in outer_bag.inner_colours) != 0
)
select sum(bag_quantity) from outer_bag where outer_colour != 'shiny gold'
;

