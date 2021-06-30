use vk;

-- Задание 2
select distinct firstname
from users
order by firstname;

-- Задание 3
alter table profiles
add column is_active bool default true;

update profiles
set is_active = 0
where (datediff(current_date(),birthday))/365<18;

-- Задание 4
delete from messages
where created_at>current_date();
