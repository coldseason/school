create database movie_theater;
set datestyle to iso,dmy;
create extension if not exists "uuid-ossp";


create sequence year_id;
create table film_year(
id int not null default nextval('year_id') primary key,
film_year varchar not null);
insert into film_year (film_year)
values
('2000'),('2001'),('2002'),('2003'),('2004'),('2005'),('2006'),('2007'),('2008'),('2009'),
('2010'),('2011'),('2012'),('2013'),('2014'),('2015'),('2016'),('2017'),('2018'),('2019'),
('2020'), ('2021'),('2022'),('2023'),('2024'),('2025');

create sequence country_id;
create table film_country(
id int not null default nextval('country_id') primary key,
film_country varchar not null);
insert into film_country(film_country)
values 
('США'),('Канада'),('Франция'),('Ирландия'),('Великобритания'),('Греция'),('Япония'),('Германия');

create sequence genre_id;
create table film_genre(
id int not null default nextval('genre_id') primary key,
film_genre varchar not null);
insert into film_genre(film_genre)
values
('Драма'),('Фантастика'),('Триллер'),('Мелодрама'),('Комедия'),('Криминал');

create sequence maker_id;
create table film_maker(
id int not null default nextval('maker_id') primary key,
film_maker varchar not null);
insert into film_maker(film_maker)
values
('Рюсукэ Хамагути'),('Йоргос Лантимос'),('Мартин МакДона'),('Жан-Пьер Жёне'),('Девид Фрэнкел');

create sequence script_id;
create table film_script_maker(
id int not null default nextval('script_id') primary key,
film_script_maker varchar not null);
insert into film_script_maker (film_script_maker)
values
('Рюсукэ Хамагути'),('Харуки Мураками'),('Эфтимис Филиппоу'),('Мартин МакДона'),('Гийом Лоран'),('Жан-Пьер Жёне'),('Алин Брош МакКенна'),('Лорен Вайсбергер');

create sequence actors_id;
create table film_actors(
id int not null default nextval('actors_id') primary key,
name_actors varchar not null);
insert into film_actors(name_actors)
values
('Хидэтоси Нисидзима'),('Колин Фаррелл'),('Брендан Глисон'), ('Одри Тоту'),('Мэрил Стрип');



create table movie_collection(
id uuid default uuid_generate_v4() primary key,
film_name_russian varchar not null,
film_name_english varchar not null,
film_year int not null references film_year(id),
film_genre int not null references film_genre(id),
film_director int not null references film_maker(id),
film_script_maker int not null references film_script_maker(id),
film_lead_actor int not null references film_actors(id));
alter table movie_collection add column film_country int;
alter table movie_collection add constraint film_country_fk
foreign key (film_country) references film_country(id);



insert into movie_collection(film_name_russian, film_name_english,
film_year, film_genre, film_director, film_script_maker, film_lead_actor, film_country)
values 
('Сядь за руль моей машины', 'Doraibu mai ka', 22, 1, 1, 2, 1, 7),
('Лобстер', 'The Lobster', 16, 2, 2, 3, 2, 8),
('Залечь на дно в Брюгге', 'In Bruges', 8, 6, 3, 4, 3, 4),
('Амели', 'Le Fabuleux destin d Amélie Poulain', 2, 4, 4, 5, 4, 3),
('Дьявол носит Prada', 'The Devil Wears Prada', 7, 5, 5, 7, 5, 1);


create table film_news(
id uuid default uuid_generate_v4() primary key,
news_date date not null,
news_header varchar not null,
news_body text not null,
news_author varchar not null,
news_comments int);

insert into film_news(news_date, news_header, news_body, news_author)
values
('10-06-2022', 'Новый выпуск Empire посвящен сериалу «Властелин колец: Кольца власти». Что мы из него узнали?',
'Июльский номер журнала Empire посвящен сериалу «Властелин колец: Кольца власти», который выйдет на Amazon Prime 2 сентября. 
Это одно из самых ожидаемых и масштабных шоу 2022 года. 
По данным Empire, на производство первого сезона ушло 462 млн долларов (дебютный сезон «Игры престолов» стоил 90 миллионов). 
Плюс Amazon заплатила 250 млн за права на произведения Дж. Р. Р. Толкина.

Действие сериала разворачивается за несколько тысяч лет до событий трилогии. 
В нем покажут и новых героев, и знакомых персонажей: эльфийку Галадриэль (Морвет Кларк), полуэльфа Элронда (Роберт Арамайо), 
нуменорского князя Исильдура (Макс Болдри), принца гномов Дурина IV (Овайн Артур). 
Мы прочитали выпуск журнала, куда вошли интервью с создателями шоу, и пересказываем самое интересное.',
'Иван Трифонов'),
('07-07-2022', 'Empire выпустил большой материал о сиквеле «Аватара». Что мы из него узнали',
'Действие сиквела развернется в океане Пандоры. 
По сюжету семейство Салли встречается с кланом рифов Меткайина, которым правят Тоновари (Клифф Кёртис) и Ронейл (Кейт Уинслет). 
Они не в восторге от появления Джейка Салли, так как понимают, что следом к ним домой явятся колонизаторы. 
Кэмерон считает, что этот момент отражает текущий мировой кризис с беженцами.

Технологическим прорывом тут стало использование техники performance capture, то есть «захвата актерской игры», под водой. 
Съемки проходили в специальном резервуаре, в который помещалось почти 4 млн литров воды. 
В нем же был установлен специальный волнопродуктор для имитации подводных течений в океане. 
Актеры отправились на тренировку на Гавайи, где учились задерживать дыхание под водой у знаменитого фридайвера Кирка Крэка. 
На съемках актеры отыгрывали сцены прямо под водой, а дубли длились по две-три минуты.',
'Михаил Моркин'),
('22-06-2022', '«Нам нужен был живой зверек». Как придумали нового Чебурашку?',
'«Чебурашка» — полнометражный игровой фильм, в котором главный герой выглядит не как игрушка, а как живое существо. 
Да и Гена здесь не крокодил, а простой садовник (его играет Сергей Гармаш). 
Елена Яковлева исполнила роль главной антагонистки — директрисы шоколадной фабрики Риммы, напоминающей старуху Шапокляк. 
В фильме Чебурашка будет настоящим зверьком, а не игрушкой. Его создают в помощью живой съемки, CG-графики и технологии захвата движений.

Согласно сюжету Чебурашка попадает в маленький город у моря, где знакомится с мальчиком, не умеющим разговаривать, 
и его мамой, которая варит самый вкусный шоколад.',
'Вася Пупкин'),
('08-06-2022', '«Сумерки», но с лисом вместо вампира. Чем хорош сериал «История девятихвостого лиса»?',
'Вслед за корейским шоу «Демон» с мая канал ТВ-3 показывает еще один популярный фэнтези-сериал из Кореи. 
Несколько недель Москва была буквально увешана рекламой «Истории девятихвостого лиса» — сериала, 
который у себя на родине транслировался в 2020-м по кабельному tvN. 

История про божественное существо кумихо, принимающее человеческий облик, 
активно набирает обороты на Кинопоиске — ее можно увидеть в нашем онлайн-кинотеатре. 
Редакция разбирается, зачем смотреть этот сериал и как он знакомит зрителей с корейским фольклором.',
'Кира Голубева'),
('31-05-2022', 'За что мы любим Райана Рейнольдса? Не только за шутки!',
'Создание фильма «Дэдпул» было непростым делом. 
После того как в 2000 году было объявлено, что Дэдпул — один из персонажей Marvel Comics, о котором будет снят фильм,
 Райан Рейнольдс сразу дал понять, что хочет участвовать в проекте. 
К началу 2004 года Рейнольдс и режиссер Дэвид С. Гойер приступили к разработке фильма, а в марте 2005 года им заинтересовалась студия Fox. 
Рейнольдс был выбран на главную роль, 
но после ряда изменений в творческом направлении и выхода в 2011 году провального «Зеленого Фонаря» с ним руководители Fox засомневались, 
стоит ли выпускать этот фильм. Но все эти годы актер разрабатывал вместе со сценаристами историю, оплачивая им гонорар из своего кармана. 
Он также выкупил права на использование в фильме фотографии актрисы из «Золотых девочек» Беатрис Артур (в комиксах Дэдпул был ее фанатом). 
После того как в июле 2014 года в сеть просочились пробы Рейнольдса, которые понравились зрителям, Fox возобновила работу над фильмом.',
'Кира Голубева');


create table user_profile(
id uuid default uuid_generate_v4() primary key,
user_name varchar not null,
user_last_name varchar not null,
user_birth_date date not null,
user_interests varchar(300));

alter table user_profile add column user_subscripton int;
insert into user_profile(user_name, user_last_name, user_birth_date)
values
('Мария', 'Титова', '08-04-1980'),
('Иван', 'Воронов', '16-08-1993'),
('Алиса', 'Селезнёва', '29-01-1989'),
('Григорий', 'Сазонов', '22-06-1971'),
('Олег', 'Пауков', '02-11-1983');
alter table user_profile add column user_nickname varchar;
alter table user_profile add column user_subscripton int;

create sequence news_comments_id;
create table news_comments(
id int not null default nextval('news_comments_id') primary key,
user_name uuid references user_profile(id),
news_comment_text text);

alter table film_news add constraint comments_fk
foreign key (news_comments) references news_comments(id);


--subscription
create sequence subscrip_id;
create table user_subscription(
id int not null default nextval('subscrip_id') primary key,
user_subsciption varchar not null);

insert into user_subscription (user_subsciption)
values
('Полная подписка'),('Частичная подписка'),('Нет подписки');

alter table user_profile add constraint subsc_fk
foreign key (user_subscripton) references user_subscription(id);
