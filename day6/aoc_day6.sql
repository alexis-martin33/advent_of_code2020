create table public.day6_input(
input varchar,
input_id serial
);

copy public.day6_input (input) 
from '/path/to/input.txt'
;


-- part 1
with 
day6_input_2 as ( 
select null as input, 0 as input_id
union all
select * from day6_input
),
--
rownum_table as (
select row_number() over() as rownum, case when input = '' then null else input end as input
from day6_input_2
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
select rownum, input, max(rownum_null) as family_group
from to_group 
group by 1,2
)
select sum(questions_yes) from (
	select *, length(alphabet) - length(translate(alphabet, fields, '')) as questions_yes from (
		select string_agg(input, ' ') as fields, family_group, 'abcdefghijklmnopqrstuvwxyz' as alphabet
		from to_listagg
		group by family_group) as alias) as alias_2
;

----------------------------------------------------------------------------------
-- part 2
with 
day6_input_2 as ( 
select null as input, 0 as line_id
union all
select * from day6_input
),
--
rownum_table as (
select row_number() over() as rownum, case when input = '' then null else input end as input
from day6_input_2
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
select rownum, input, max(rownum_null) as family_group
from to_group 
group by 1,2
)
--
select sum(questions_yes) from (
select *, length(alphabet) - length(translate(alphabet, all_answered_yes, '')) as questions_yes from (
select *, translate(fields, alphabet_missing, '') as all_answered_yes, 'abcdefghijklmnopqrstuvwxyz' as alphabet from (
select family_group, string_agg(translate('abcdefghijklmnopqrstuvwxyz', input, ''),' ') as alphabet_missing,
string_agg(input, ' ') as fields 
from to_listagg
group by family_group) as alias) as alias_2) as alias_3
;


