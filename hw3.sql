use vk;

drop table if exists institutions; -- Учебное заведение
create table institutions (
	id serial,
	institution_type enum('school', 'university', 'college', 'training course'), -- Тип этого учебного заведения
	name varchar(300) not null,
	address varchar(300) not null,
	index institution_name(name) -- Индекс по названию заведения
	-- Можно ли явно не задавать первичный ключ, если уникальность строк и так гарантирована типом serial? 
);

drop table if exists user_education; -- Учебные заведения пользователя
create table user_education (
	user_id bigint unsigned not null,
	institution_id bigint unsigned not null,
	graduated_date date,
	specialization varchar(100),
	foreign key (user_id) references users(id),
	foreign key (institution_id) references institutions(id),
	primary key unique_data (user_id, institution_id, graduated_date, specialization)
	-- Сделал составной первичный ключ, который не допустит появления полностью идентичных строк.
	-- Насколько приемлимо делать его именно таким?
);



drop table if exists personal_interests; -- Интерeсы пользователя
create table personal_interests (
	user_id bigint unsigned not null primary key,
	interests text,
	fav_book text,
	fav_mov text,
	fav_things text,
	fav_cite varchar(800),
	foreign key (user_id) references users(id)
);



drop table if exists presents; -- Возможные подарки
create table presents (
	id serial,
	name varchar(100) not null unique,
	present_img blob
);

drop table if exists user_presents; -- Подарки пользователя
create table user_presents (
	user_id bigint unsigned not null,
	from_user_id bigint unsigned not null,
	present_id bigint unsigned not null,
	message text,
	given_at datetime default now(),
	foreign key (user_id) references users(id),
	foreign key (from_user_id) references users(id),
	foreign key (present_id) references presents(id)
);