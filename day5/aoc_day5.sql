-- initialize table
create table public.day5_input(
input varchar
);

--
copy public.day5_input 
from '/path/to/input.txt'
delimiter ',';

-- Part 1
-- find the column seat assignment
with column_assignment as (
select  rownum,
case when substring(column_seat from 1 for 1) = 'R' then upper_bound
 	 when substring(column_seat from 1 for 1) = 'L' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
	 as column_assignment
--
from(
--
	select rownum, 
	right(column_seat,1) as column_seat,
	case when substring(column_seat from 1 for 1) = 'R' then upper_bound
	 	 when substring(column_seat from 1 for 1) = 'L' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
		 as upper_bound,
	--
	case when substring(column_seat from 1 for 1) = 'R' then (upper_bound - lower_bound +1)/2 + lower_bound
	 	 when substring(column_seat from 1 for 1) = 'L' then lower_bound END     
	 as lower_bound
	 --
	from(
		select rownum, 
		right(column_seat,2) as column_seat,
		case when substring(column_seat from 1 for 1) = 'R' then upper_bound
			 when substring(column_seat from 1 for 1) = 'L' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
			 as upper_bound,
		case when substring(column_seat from 1 for 1) = 'R' then (upper_bound - lower_bound +1)/2 + lower_bound
			 when substring(column_seat from 1 for 1) = 'L' then lower_bound END     
			 as lower_bound
		from (
			select 
			row_number() over () as rownum,
			right(input,3) as column_seat,
			0 as lower_bound,
			7 as upper_bound
			from day5_input
			) as alias) as alias_2) as alias_3),
--
row_assignment as (
select  rownum,
case when substring(column_seat from 1 for 1) = 'B' then upper_bound
 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
	 as row_assignment
--
from(
select rownum, 
	right(column_seat,1) as column_seat,
	case when substring(column_seat from 1 for 1) = 'B' then upper_bound
	 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
		 as upper_bound,
	--
	case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
	 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
	 as lower_bound,
	 input
	 --
from(
	select rownum, 
		right(column_seat,2) as column_seat,
		case when substring(column_seat from 1 for 1) = 'B' then upper_bound
		 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
			 as upper_bound,
		--
		case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
		 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
		 as lower_bound,
		 input
		 --
	from(
		select rownum, 
			right(column_seat,3) as column_seat,
			case when substring(column_seat from 1 for 1) = 'B' then upper_bound
			 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
				 as upper_bound,
			--
			case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
			 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
			 as lower_bound,
			 input
			 --
		from(
			select rownum, 
				right(column_seat,4) as column_seat,
				case when substring(column_seat from 1 for 1) = 'B' then upper_bound
				 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
					 as upper_bound,
				--
				case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
				 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
				 as lower_bound,
				 input
				 --
				from(
			--
					select rownum, 
					right(column_seat,5) as column_seat,
					case when substring(column_seat from 1 for 1) = 'B' then upper_bound
					 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
						 as upper_bound,
					--
					case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
					 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
					 as lower_bound,
					 input
					 --
					from(
						select rownum, 
						right(column_seat,6) as column_seat,
						case when substring(column_seat from 1 for 1) = 'B' then upper_bound
							 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
							 as upper_bound,
						case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
							 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
							 as lower_bound,
							 input
						from (
							select 
							row_number() over () as rownum,
							substring(input from 1 for 7) as column_seat,
							0 as lower_bound,
							127 as upper_bound,
							substring(input from 1 for 7) as input
							from 
							day5_input
							) as alias) as alias_2) as alias_3) as alias_4) as alias_5) as alias_6) as alias_7)
--
select max(row_assignment.row_assignment * 8 + column_assignment.column_assignment) as seat_id_max
from column_assignment
left join row_assignment on column_assignment.rownum = row_assignment.rownum
;

----------------------------------------------------------------------------------------------------------------
-- part 2
with column_assignment as (
select  rownum,
case when substring(column_seat from 1 for 1) = 'R' then upper_bound
 	 when substring(column_seat from 1 for 1) = 'L' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
	 as column_assignment
--
from(
--
	select rownum, 
	right(column_seat,1) as column_seat,
	case when substring(column_seat from 1 for 1) = 'R' then upper_bound
	 	 when substring(column_seat from 1 for 1) = 'L' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
		 as upper_bound,
	--
	case when substring(column_seat from 1 for 1) = 'R' then (upper_bound - lower_bound +1)/2 + lower_bound
	 	 when substring(column_seat from 1 for 1) = 'L' then lower_bound END     
	 as lower_bound
	 --
	from(
		select rownum, 
		right(column_seat,2) as column_seat,
		case when substring(column_seat from 1 for 1) = 'R' then upper_bound
			 when substring(column_seat from 1 for 1) = 'L' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
			 as upper_bound,
		case when substring(column_seat from 1 for 1) = 'R' then (upper_bound - lower_bound +1)/2 + lower_bound
			 when substring(column_seat from 1 for 1) = 'L' then lower_bound END     
			 as lower_bound
		from (
			select 
			row_number() over () as rownum,
			right(input,3) as column_seat,
			0 as lower_bound,
			7 as upper_bound
			from day5_input
			) as alias) as alias_2) as alias_3),
--
row_assignment as (
select  rownum,
case when substring(column_seat from 1 for 1) = 'B' then upper_bound
 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
	 as row_assignment
--
from(
select rownum, 
	right(column_seat,1) as column_seat,
	case when substring(column_seat from 1 for 1) = 'B' then upper_bound
	 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
		 as upper_bound,
	--
	case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
	 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
	 as lower_bound,
	 input
	 --
from(
	select rownum, 
		right(column_seat,2) as column_seat,
		case when substring(column_seat from 1 for 1) = 'B' then upper_bound
		 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
			 as upper_bound,
		--
		case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
		 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
		 as lower_bound,
		 input
		 --
	from(
		select rownum, 
			right(column_seat,3) as column_seat,
			case when substring(column_seat from 1 for 1) = 'B' then upper_bound
			 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
				 as upper_bound,
			--
			case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
			 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
			 as lower_bound,
			 input
			 --
		from(
			select rownum, 
				right(column_seat,4) as column_seat,
				case when substring(column_seat from 1 for 1) = 'B' then upper_bound
				 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
					 as upper_bound,
				--
				case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
				 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
				 as lower_bound,
				 input
				 --
				from(
			--
					select rownum, 
					right(column_seat,5) as column_seat,
					case when substring(column_seat from 1 for 1) = 'B' then upper_bound
					 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
						 as upper_bound,
					--
					case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
					 	 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
					 as lower_bound,
					 input
					 --
					from(
						select rownum, 
						right(column_seat,6) as column_seat,
						case when substring(column_seat from 1 for 1) = 'B' then upper_bound
							 when substring(column_seat from 1 for 1) = 'F' then lower_bound +((upper_bound - lower_bound - 1)/2) END     
							 as upper_bound,
						case when substring(column_seat from 1 for 1) = 'B' then (upper_bound - lower_bound +1)/2 + lower_bound
							 when substring(column_seat from 1 for 1) = 'F' then lower_bound END     
							 as lower_bound,
							 input
						from (
							select 
							row_number() over () as rownum,
							substring(input from 1 for 7) as column_seat,
							0 as lower_bound,
							127 as upper_bound,
							substring(input from 1 for 7) as input
							from 
							day5_input
							) as alias) as alias_2) as alias_3) as alias_4) as alias_5) as alias_6) as alias_7),
seat_ids as (select row_assignment.row_assignment * 8 + column_assignment.column_assignment as seat_id
from column_assignment
left join row_assignment on column_assignment.rownum = row_assignment.rownum)
--
select seat_ids1.seat_id - 1 as solution
from seat_ids as seat_ids1
left join seat_ids as seat_ids2 on seat_ids1.seat_id = seat_ids2.seat_id +1
where seat_ids2.seat_id is null and seat_ids1.seat_id != 13
;

				

