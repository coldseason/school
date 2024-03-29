create database school;
create extension if not exists "uuid-ossp";


create sequence week_id;
create table week(
id int not null default nextval('week_id') primary key,
day_of_week varchar);
insert into week(day_of_week)
values('Monday'),('Tuesday'),('Wednesday'),('Thursday'),('Friday'),('Saturday'),('Sunday');

create sequence month_id;
create table months(
id int not null default nextval('month_id') primary key,
months varchar);
insert into months(months)
values('January'),('February'),('March'),('April'),('May'),('June'),('July'),('August'),('September'),('October'),('November'),('December');


create sequence lessons_id;
create table lessons(
id int not null default nextval('lessons_id') primary key,
lesson varchar);

insert into lessons(lesson)
values
('Ручное тестирование ПО'),
('Основы системного администрирования и сетевых технологий'),
('Основы программирования на Python'),
('Теория баз данных'),
('Основы автоматизированного тестирования');

create sequence teacher_id;
create table teachers(
id int not null default nextval('teacher_id') primary key,
teacher varchar);

insert into teachers(teacher)
values
('Иванов Александр Николаевич'),
('Козякина Елена'),
('Васильевых Александр'),
('Гридчина Алевтина Александровна');

create sequence auditorium_id;
create table auditorium(
id int not null default nextval('auditorium_id') primary key,
auditorium varchar);

insert into auditorium (auditorium)
values
('ауд 1'),
('ауд 2'),
('ауд 3'),
('ауд 4'),
('ауд 5'),
('ауд 6'),
('ауд 7'),
('ауд 8'),
('ауд 9'),
('ауд 10');

create sequence time_id;
create table lessons_time(
id int not null default nextval('time_id') primary key,
times varchar,
lesson_number int);

insert into lessons_time(times, lesson_number)
values 

('10:00 - 11:20', 1),
('10:30 - 11:50', 2),
('12:00 - 13:20', 3),
('13:00 - 14:20', 4),
('14:30 - 15:50', 5),
('15:00 - 16:20', 7),
('16:00 - 17:20', 6),
('16:30 - 17:50', 8),
('17:00 - 18:20', 9),
('18:00 - 19:20', 10),
('18:30 - 19:50', 12),
('19:00 - 20:20', 11),
('20:00 - 21:20', 13);


create table edu_records(
id uuid default uuid_generate_v4() primary key,
lesson_id int not null references lessons(id),
time_id int not null references lessons_time(id),
auditorium_id int not null references auditorium(id),
teacher_id int not null references teachers(id));


insert into edu_records(lesson_id, time_id, auditorium_id, teacher_id)
values
(1, 7, 3, 1),
(1, 13, 3, 1);


insert into edu_records(lesson_id, time_id, auditorium_id, teacher_id)
values
(2, 7, 3, 1),
(2, 13, 3, 1);


create sequence calender_id;
create table calendar(
id int not null default nextval('calender_id') primary key,
month_id int not null references months(id),
week_id int not null references week(id),
cur_date date not null,
edu_record uuid references edu_records(id));

insert into calendar (month_id, week_id, cur_date)
values
(1, 3, '2022-01-12'),
(1, 3, '2022-01-12'),
(1, 5, '2022-01-14'),
(1, 5, '2022-01-14'),
(1, 3, '2022-01-19'),
(1, 3, '2022-01-19'),
(1, 5, '2022-01-21'),
(1, 5, '2022-01-21'),
(1, 3, '2022-01-26'),
(1, 3, '2022-01-26'),
(1, 5, '2022-01-28'),
(1, 5, '2022-01-28');



create sequence theme_id;
create table lessons_theme(
id int not null default nextval('theme_id') primary key,
lessons_theme varchar);

insert into lessons_theme (lessons_theme) 
values 
('GIT'),
('Linux'),
('Linux Final'),
('CV'),
('Cisco'),
('Exam'),
('Chrome DevTools'),
('Security'),
('Kali'),
('Testing');


create sequence grade_id;
create table grades(
id int not null default nextval('grade_id') primary key,
grade int);

insert into grades(grade)
values
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12);

create sequence meaning_id;
create table grades_meaning(
id int not null default nextval ('meaning_id') primary key,
grades_meaning varchar);

insert into grades_meaning(grades_meaning)
values
('Home work'), ('Class work'), ('Laboratory work'), ('Tests');

create sequence present_id;
create table student_presents(
id int not null default nextval('present_id') primary key,
presents varchar);

insert into student_presents(presents)
values
('Absence'), ('Lateness'), ('Present');


create table student_grade(
id uuid default uuid_generate_v4() primary key,
student_grade int not null references grades(id),
grade_meaning int not null references grades_meaning(id));

insert into student_grade(student_grade, grade_meaning)
values (1, 1), (2, 1),(3, 1),(4, 1),(5, 1),(6, 1),(7, 1),(8, 1),(9, 1),(10, 1),(11, 1), (12, 1),
(1, 2), (2, 2),(3, 2),(4, 2),(5, 2),(6, 2),(7, 2),(8, 2),(9, 2),(10, 2),(11, 2), (12, 2),
(1, 3), (2, 3),(3, 3),(4, 3),(5, 3),(6, 3),(7, 3),(8, 3),(9, 3),(10, 3),(11, 3), (12, 3),
(1, 4), (2, 4),(3, 4),(4, 4),(5, 4),(6, 4),(7, 4),(8, 4),(9, 4),(10, 4),(11, 4), (12, 4);


create sequence number_of_class;
create table grades_main_table(
id uuid default uuid_generate_v4() primary key,
date_id int not null references calendar(id),
number_of_lesson int not null default nextval('number_of_class'),
lesson_name_id int not null references lessons(id),
class_number_id int not null references lessons_time(id),
teacher_id int not null references teachers(id),
lesson_theme int not null references lessons_theme(id),
grade_id uuid references student_grade(id),
student_status int not null references student_presents(id));


insert into grades_main_table (date_id, lesson_name_id, class_number_id, teacher_id, lesson_theme, student_status)
values 
(1, 1, 13, 1, 1, 3);


create sequence homework_status_id;
create table homework_status(
id int not null default nextval('homework_status_id') primary key,
homework_status varchar);
insert into homework_status (homework_status)
values('Current'),('Under review'),('Verified'),('Overdue');


create sequence homework_info_id;
create table homework_info(
id int not null default nextval('homework_info_id') primary key,
lesson_name int not null references lessons(id),
date_of_issue date not null,
lesson_theme int not null references lessons_theme(id),
teacher int not null references teachers(id),
teacher_comment varchar);

create table homework_base(
id uuid default uuid_generate_v4() primary key,
homework_path varchar not null,
homework_info_id int not null references homework_info(id),
date_load_up_to date not null,
date_of_download date,
homework_status_id int not null references homework_status(id));


create sequence announcement_id;
create table announcement(
id int not null default nextval('announcement_id') primary key,
announcement text,
date_of_announcement date);
insert into announcement(announcement, date_of_announcement)
values
('Добрый день!

ВАЖНО

В связи с изменением компанией Google политики безопастности большая часть ссылок на книги, размещенные в Journal, стала нерабочей. Из-за того, что нерабочих ссылок достаточно много, их обновление займет какое-то время.

Первыми обновятся ссылки, по которым уже пришли сообщения от студентов или преподавателей. Приносим извинения за неудобства.', '2021-10-04'),
('Добрый день, Уважаемые студены и их родители. 

В период с 29.10 по 07.11 каникул НЕ будет. Занятия продолжаем в стандартном режиме. А так же напоминаем об необходимости присутствовать на парах и выполнять домашние задания. 

Желаем всем хорошего дня и успехов  в учебе!', '2021-10-28'),
('Добрый день. Дорогие студенты!

В период с 27.12.21 по 09.01.22 (включительно) состояться зимние каникулы.

Напоминаем о важности выполнения домашних заданий, поэтому рекомендуем за эти продолжительные выходные,  подтянуть  и доздать свои невыполненные работы.

А так же хотим Вас поздравить с Наступающим Новым Годом и пожелать успехов в учебе, больших и маленьких побед и самое главное крепкого здоровья!

Всем удачных и веселых выходных!', '2021-12-13');




create sequence lesson_books_id;
create table lessons_books(
id int not null default nextval('lesson_books_id') primary key,
lessons_book_path varchar not null,
name_lesson_book varchar not null,
upload_date date not null);


create sequence library_id;
create table lib(
id int not null default nextval('library_id') primary key,
lib_books_path varchar not null,
upload_date date not null);


create sequence video_id;
create table video(
id int not null default nextval('video_id') primary key,
video_path varchar not null,
video_name varchar not null,
upload_date date not null);


create sequence articale_id;
create table articales(
id int not null default nextval('articale_id') primary key,
articales_path varchar not null,
articales_name varchar not null,
upload_date date not null);


create sequence practic_id;
create table practic_material(
id int not null default nextval('practic_id') primary key,
practic_material_path varchar not null,
practic_material_name varchar not null,
practic_material_info varchar not null,
upload_date date not null);

create sequence test_info_id;
create table test_info(
id int not null default nextval('test_info_id') primary key,
question_num int not null,
decision_time time not null,
time_interval time not null);

create sequence test_attempts_id;
create table test_attempts(
id int not null default nextval('test_attempts_id') primary key,
test_attempts int not null,
total_attempts int not null);

create sequence tests_id;
create table tests(
id int not null default nextval('tests_id') primary key,
test_item varchar not null,
test_info_id int not null references test_info(id),
test_grade int,
test_attempts_id int references test_attempts(id),
upload_date date not null);


create sequence edu_mat_id;
create table educational_materials(
id int not null default nextval('edu_mat_id') primary key,
lessons_id int not null references lessons(id),
lessons_books_id int not null references lessons_books(id),
lib_id int not null references lib(id),
video_id int not null references video(id),
articales_id int not null references articales(id),
practic_material_id int not null references practic_material(id),
tests_id int not null references tests(id));



create table bills(
id uuid default uuid_generate_v4() primary key,
bills_path varchar);

create sequence p_schedule;
create table payment_schedule(
id int not null default nextval('p_schedule') primary key,
pay_up_to date not null,
payment_description varchar,
to_pay int not null);

create sequence p_details;
create table payment_details(
id int not null default nextval('p_details') primary key,
recipient varchar not null,
inn int8 not null,
bik int8 not null,
checking_account varchar not null,
purpose_of_payment varchar not null);


insert into payment_details (recipient, inn, bik, checking_account,
purpose_of_payment)
values('Филиал «Академия Шаг Ярославль» 
Автономная некоммерческая организация дополнительного 
профессионального образования «Академия Шаг»', 7730257499, 044525700, 
'40703810500000002865', 'Нет суммы по графику 1C код: 199017632 ');

create table payment_history(
id uuid default uuid_generate_v4() primary key,
payment_date date not null,
purpose_of_payment varchar not null,
paid int not null);

create sequence payments_id;
create table payments(
id int not null default nextval('payments_id') primary key,
bill_id uuid not null references bills(id),
payment_schedule_id int not null references payment_schedule(id),
payment_details_id int not null references payment_details(id),
payment_history_id uuid not null references payment_history(id));


create table personal_info(
id uuid default uuid_generate_v4() primary key,
name varchar not null,
second_name varchar not null,
last_name varchar not null,
birth_date date not null);

create table contact_info(
id uuid default uuid_generate_v4() primary key,
phone_num varchar not null,
email varchar not null,
home_address varchar not null);

create table other_info(
id uuid default uuid_generate_v4() primary key,
study varchar,
social_link varchar);

create table personal_area(
id uuid default uuid_generate_v4() primary key,
personal_info_id uuid not null references personal_info(id),
contact_info_id uuid not null references contact_info(id),
other_info_id uuid references other_info(id));


create sequence main_table_id;
create table main_table(
id int not null default nextval('main_table_id') primary key,
schedule_calendar_id int not null references calendar(id),
grades_main_table_id uuid not null references grades_main_table(id),
homework_base_id uuid not null references homework_base(id),
educational_materials_id int not null references educational_materials(id),
announcement_id int not null references announcement(id),
payments_id int not null references payments(id),
personal_area_id uuid not null references personal_area(id));
