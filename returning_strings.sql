-- # Returning Strings SQL

/*
Write a select statement that takes name from person table and return "Hello, <name> how are you doing today?" results in a column named greeting
*/


select format('Hello, %s how are you doing today?', name) as greeting
from person

select 'Hello, ' || name || ' how are you doing today?' as greeting from person

--#