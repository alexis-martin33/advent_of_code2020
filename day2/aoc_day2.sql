create table public.day2_input(
input varchar
);

copy public.day2_input 
from '/path/to/file.csv'
delimiter ',' csv;

-- Part 1
select count(*) 
from (
	select 
			char_length(passwrd) - char_length(replace(passwrd, letter, '')) >= min_num::INTEGER AND
			char_length(passwrd) - char_length(replace(passwrd, letter, '')) <= max_num::INTEGER as passwrd_ok
	from (
		select split_part(input, '-', 1) as min_num,
		       split_part(split_part(input, '-', 2), ' ', 1) as max_num,
		       split_part(split_part(input, ' ', 2), ':', 1) as letter,
		       split_part(input, ': ', 2) as passwrd
		from day2_input) as alias) as alias_2
where passwrd_ok is TRUE ;
		
-- Part 2
select count(*) from (
	select 
	-- Check if the letter at position min_num and max_num are equal or not to the letter we want
		(substring(passwrd from min_num::INTEGER for 1) = letter AND
		substring(passwrd from max_num::INTEGER for 1) != letter) or
		(substring(passwrd from min_num::INTEGER for 1) != letter AND
		substring(passwrd from max_num::INTEGER for 1) = letter) as passwrd_ok
	from (   
		select split_part(input, '-', 1) as min_num,
		       split_part(split_part(input, '-', 2), ' ', 1) as max_num,
		       split_part(split_part(input, ' ', 2), ':', 1) as letter,
		       split_part(input, ': ', 2) as passwrd
		from day2_input) as alias) as alias_2
where passwrd_ok is TRUE;
	
	