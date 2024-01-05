drop table if exists game_set;
drop table if exists game;
drop table if exists team;
drop table if exists player;
drop table if exists question_options;
drop table if exists question;
drop table if exists question_set;

create table player (
                        id serial PRIMARY KEY,
                        name VARCHAR (60) UNIQUE NOT NULL,
                        role char not null
);

create table team (
                      id serial PRIMARY KEY,
                      kid_player_id int references player(id),
                      adult_player_id int references player(id)
);

create table question_set (
                              id serial PRIMARY KEY,
                              name VARCHAR (60) NOT NULL
);

create table question (
                          id serial PRIMARY KEY,
                          set_id int references question_set(id),
                          "number" int not null,
                          text varchar(2500) not null,
                          type char not null,
                          target char not null
);

create table question_options (
                                  question_id int references question(id),
                                  "order" int not null,
                                  text varchar(2500) not null,
                                  correct bool
);

create table game (
                      id serial PRIMARY KEY,
                      name VARCHAR (60) UNIQUE NOT NULL
);

create table game_set (
                          id serial PRIMARY KEY,
                          game_id int references game(id),
                          "order" int not null,
                          team_id int references team(id),
                          set_id int references question_set(id)
);

insert into game(name) values('Dia de reis');

insert into player(name, role) values('Jan', 'K'); -- 1
insert into player(name, role) values('Max', 'K'); -- 2
insert into player(name, role) values('Ricard', 'A'); -- 3
insert into player(name, role) values('Laura', 'A'); -- 4
insert into player(name, role) values('Gerard', 'A'); -- 5
insert into player(name, role) values('Esther', 'A'); -- 6
insert into player(name, role) values('Ismael', 'A'); -- 7
insert into player(name, role) values('Jordi', 'A'); -- 8
insert into player(name, role) values('Maria', 'A'); -- 9
insert into player(name, role) values('Montse', 'A'); -- 10

insert into team(kid_player_id, adult_player_id) values(1, 3); -- 1 Ricard&Jan
insert into team(kid_player_id, adult_player_id) values(2, 7); -- 2 Isma&Max
insert into team(kid_player_id, adult_player_id) values(1, 8); -- 3 Jan&Jordi
insert into team(kid_player_id, adult_player_id) values(2, 10); -- 4 MaxMontse
insert into team(kid_player_id, adult_player_id) values(1, 5); -- 5 JanGerard
insert into team(kid_player_id, adult_player_id) values(2, 9); -- 6 MaxMaria
insert into team(kid_player_id, adult_player_id) values(1, 6); -- 6 JanEsther

insert into question_set(name) values('JanRicard_1'); -- 1
insert into question(set_id, "number", text, type, target) values(1, 1, 'Quantes vegades ha guanyat Messi el mundial amb la selecció argentina?', 'O', 'K'); -- 1
insert into question_options(question_id, "order", text, correct) values(1, 1, 'Cap ni una', false);
insert into question_options(question_id, "order", text, correct) values(1, 2, 'Una vegada', true);
insert into question_options(question_id, "order", text, correct) values(1, 3, 'Dues vegades', false);
insert into question_options(question_id, "order", text, correct) values(1, 4, 'Trenta vegades', false);

insert into question(set_id, "number", text, type, target) values(1, 2, 'Quin animal corre més ràpid, un cangur o un bufal?', 'O', 'T'); -- 2
insert into question_options(question_id, "order", text, correct) values(2, 1, 'El cangur', false);
insert into question_options(question_id, "order", text, correct) values(2, 2, 'El bufal', true);

insert into question_set(name) values('IsmaelMax_1'); -- 2
insert into question(set_id, "number", text, type, target) values(2, 1, 'Com es diu el dolent de Star Wars que porta una màscara negra?', 'O', 'K'); -- 3
insert into question_options(question_id, "order", text, correct) values(3, 1, 'Darth Vader', true);
insert into question_options(question_id, "order", text, correct) values(3, 2, 'Sauron', false);
insert into question_options(question_id, "order", text, correct) values(3, 3, 'Lord Voldemort', false);
insert into question_options(question_id, "order", text, correct) values(3, 4, 'Luke Skywalker', false);
insert into question(set_id, "number", text, type, target) values(2, 2, 'De quin color es es sabre làser de Yoda', 'O', 'T'); -- 4
insert into question_options(question_id, "order", text, correct) values(4, 1, 'Blau', false);
insert into question_options(question_id, "order", text, correct) values(4, 2, 'Vermell', false);
insert into question_options(question_id, "order", text, correct) values(4, 3, 'Verd', true);
insert into question_options(question_id, "order", text, correct) values(4, 3, 'Lila', false);
insert into question(set_id, "number", text, type, target) values(2, 3, 'Al voltant de quantes formes de comunicació domina C-3PO?', 'O', 'A'); -- 5
insert into question_options(question_id, "order", text, correct) values(5, 1, 'Sis millions', true);
insert into question_options(question_id, "order", text, correct) values(5, 2, '18 millions', false);
insert into question_options(question_id, "order", text, correct) values(5, 2, 'Tres-centes mil', false);
insert into question_options(question_id, "order", text, correct) values(5, 2, 'Dos millions', false);
-- Ou d'astruç pesa fins 1,5kg. Cada ou de gallina talla L pesa fin a 73 gr


insert into question_set(name) values('JanJordi_1'); -- 3
insert into question(set_id, "number", text, type, target) values(3, 1, 'Quina era la velocitat màxima que agafava el primer citroën 2CV fabricat el 1948?', 'O', 'A'); -- 6
insert into question_options(question_id, "order", text, correct) values(6, 1, '320 km/h', false);
insert into question_options(question_id, "order", text, correct) values(6, 2, '62 km/h', false);
insert into question_options(question_id, "order", text, correct) values(6, 3, '58 km/h', false);
insert into question_options(question_id, "order", text, correct) values(6, 4, '66 km/h', true);
insert into question(set_id, "number", text, type, target) values(3, 2, 'A quin riu desenboca la riera de Sant Fost', 'O', 'K'); -- 7
insert into question_options(question_id, "order", text, correct) values(7, 1, 'Besos', true);
insert into question_options(question_id, "order", text, correct) values(7, 2, 'Llobregat', false);
insert into question_options(question_id, "order", text, correct) values(7, 3, 'Ter', false);
insert into question_options(question_id, "order", text, correct) values(7, 4, 'Amazonas', false);
insert into question(set_id, "number", text, type, target) values(3, 3, 'Que por arribar a pesar mes, un ou d''estruç o 20 ous de gallina tamany L?', 'O', 'T'); -- 8
insert into question_options(question_id, "order", text, correct) values(8, 1, 'Un ou d''estruç', true);
insert into question_options(question_id, "order", text, correct) values(8, 2, '20 ous de gallina', false);


insert into question_set(name) values('MaxMontse_1'); -- 4
insert into question(set_id, "number", text, type, target) values(4, 1, 'Segons el chef José Andrés, la truita de patates millor amb ou o sense?', 'O', 'T'); -- 9
insert into question_options(question_id, "order", text, correct) values(9, 1, 'Sense ceba (sincebollista)', false);
insert into question_options(question_id, "order", text, correct) values(9, 2, 'Amb ceba (concebollista)', true);
insert into question(set_id, "number", text, type, target) values(4, 2, 'Quin dos anys va ser considerat el Celler de Can Roca com el millor restaurant del món?', 'O', 'A'); -- 10
insert into question_options(question_id, "order", text, correct) values(10, 1, '2011 i 2013', false);
insert into question_options(question_id, "order", text, correct) values(10, 2, '2012 i 2014', false);
insert into question_options(question_id, "order", text, correct) values(10, 3, '2013 i 2015', true);
insert into question_options(question_id, "order", text, correct) values(10, 4, '2014 i 2016', false);
insert into question(set_id, "number", text, type, target) values(4, 1, 'Quin heroi del Venjadors porta un martell anomenat Mjolnir?', 'O', 'K'); -- 11
insert into question_options(question_id, "order", text, correct) values(11, 1, 'Capità Amèrica', false);
insert into question_options(question_id, "order", text, correct) values(11, 2, 'Hulk', false);
insert into question_options(question_id, "order", text, correct) values(11, 3, 'Súper Lopez', false);
insert into question_options(question_id, "order", text, correct) values(11, 4, 'Thor', true);

insert into question_set(name) values('JanGerard_1'); -- 5
insert into question(set_id, "number", text, type, target) values(5, 1, 'Cuantes vegades ha guanyat Messi el Mundial amb Argentina?', 'O', 'K'); -- 12
insert into question_options(question_id, "order", text, correct) values(12, 1, 'Cap vegada', false);
insert into question_options(question_id, "order", text, correct) values(12, 2, 'Una vegada', true);
insert into question_options(question_id, "order", text, correct) values(12, 3, 'Dues vegades', false);
insert into question_options(question_id, "order", text, correct) values(12, 4, '10 vegades', false);
insert into question(set_id, "number", text, type, target) values(5, 2, 'Quins bessons practicaven la ''Catapulta Infernal'' a la sèrie de dibuixos animats ''Oliver i Benji''?', 'O', 'T'); -- 13
insert into question_options(question_id, "order", text, correct) values(13, 1, 'Hermanos Calatraba', false);
insert into question_options(question_id, "order", text, correct) values(13, 2, 'Hermanos Darrel', false);
insert into question_options(question_id, "order", text, correct) values(13, 3, 'Hermanos Jonas', false);
insert into question_options(question_id, "order", text, correct) values(13, 4, 'Hermanos Derrick', true);
insert into question(set_id, "number", text, type, target) values(5, 3, 'Quina va ser la darrera temporada de Tarzán Migueli amb el Barça?', 'O', 'A'); -- 14
insert into question_options(question_id, "order", text, correct) values(14, 1, '1989', true);
insert into question_options(question_id, "order", text, correct) values(14, 2, '1987', false);
insert into question_options(question_id, "order", text, correct) values(14, 3, '1990', false);
insert into question_options(question_id, "order", text, correct) values(14, 3, '1991', false);

insert into question_set(name) values('MaxMaria_1'); -- 6
insert into question(set_id, "number", text, type, target) values(5, 1, 'Quants habitants tenia Benissanet al 2018?', 'O', 'A'); -- 15
insert into question_options(question_id, "order", text, correct) values(15, 1, '1.214', false);
insert into question_options(question_id, "order", text, correct) values(15, 2, '2.345.999', false);
insert into question_options(question_id, "order", text, correct) values(15, 3, '1.412', false);
insert into question_options(question_id, "order", text, correct) values(15, 4, '1.142', true);
insert into question(set_id, "number", text, type, target) values(5, 1, 'Com es diu el Germà de la Peppa pig?', 'O', 'K'); -- 16
insert into question_options(question_id, "order", text, correct) values(16, 1, 'Pedro Pig', false);
insert into question_options(question_id, "order", text, correct) values(16, 2, 'Geroge Pig', true);
insert into question_options(question_id, "order", text, correct) values(16, 3, 'Max Pig', false);
insert into question(set_id, "number", text, type, target) values(5, 1, 'Com es diu el Germà de la Pepa pig?', 'O', 'T'); -- 17

insert into question_set(name) values('JanEsther_1'); -- 7
insert into question(set_id, "number", text, type, target) values(4, 1, 'Quants cims de més de 3000 metre d''alçada hi ha al Pirineu?', 'O', 'A'); -- 18
insert into question_options(question_id, "order", text, correct) values(18, 1, '126', false);
insert into question_options(question_id, "order", text, correct) values(18, 1, '212', true);
insert into question_options(question_id, "order", text, correct) values(18, 1, '3.000', false);
insert into question_options(question_id, "order", text, correct) values(18, 1, '189', false);
insert into question(set_id, "number", text, type, target) values(4, 1, 'Quants cims de més de 3000 metre d''alçada hi ha al Pirineu?', 'O', 'A'); -- 18


--insert into question(set_id, "number", text, type, target) values(4, 1, 'Quants cims de més de 3000 metre d''alçada hi ha al Pirineu?', 'O', 'A'); -- 4
--insert into question_options(question_id, "order", text, correct) values(6, 1, '320 km/h', false);

-- Esther
-- insert into question(set_id, "number", text, type, target) values(2, 1, 'De quins colors es la equipació del Marto?', 'O', 'K'); -- 3
-- insert into question(set_id, "number", text, type, target) values(2, 2, 'Que por attibar a pesar mes, un ou d''astruç o 20 ous de gallina tamany L?', 'O', 'T'); -- 5
-- insert into question_options(question_id, "order", text, correct) values(5, 1, 'Un ou d''astruç', true);



insert into game_set(game_id, "order", team_id, set_id) values(1, 1, 1, 1);  -- RicardJan
insert into game_set(game_id, "order", team_id, set_id) values(1, 2, 2, 2);  -- IsmaMax
insert into game_set(game_id, "order", team_id, set_id) values(1, 3, 3, 3);  -- JordiJan
insert into game_set(game_id, "order", team_id, set_id) values(1, 4, 4, 4);  -- MontseMax
insert into game_set(game_id, "order", team_id, set_id) values(1, 5, 5, 5);  -- GerardJan

