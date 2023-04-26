DROP DATABASE IF EXISTS soccer_league;
CREATE DATABASE soccer_league;

\c soccer_league;

CREATE TABLE "team" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50)
);

CREATE INDEX team_name ON team(name);

CREATE TABLE "player" (
  "id" SERIAL PRIMARY KEY,
  "team_id" INT REFERENCES team(id),
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50)
);

CREATE INDEX player_name ON player(first_name , last_name);

CREATE TABLE "referee" (
  "id" SERIAL PRIMARY KEY,
  "first_name" VARCHAR(50),
  "last_name" VARCHAR(50)
);
CREATE INDEX referee_name ON referee(first_name , last_name);

CREATE TABLE "season" (
  "id" SERIAL PRIMARY KEY,
  "name" VARCHAR(50),
  "start_date" TIMESTAMP,
  "end_date" TIMESTAMP
);

CREATE TABLE "match" (
  "id" SERIAL PRIMARY KEY,
  "match_date" TIMESTAMP,
  "season_id" INT REFERENCES season(id),
  "team_1" INT REFERENCES team(id),
  "team_2" INT REFERENCES team(id)
);

CREATE TABLE "match_referee" (
  "id" SERIAL PRIMARY KEY,
  "match_id" INT REFERENCES match(id),
  "referee_id" INT REFERENCES referee(id),
  "is_main_ref" BOOLEAN DEFAULT TRUE
);

CREATE TABLE "goal" (
  "id" SERIAL PRIMARY KEY,
  "season_id" INT REFERENCES season(id),
  "match_id" INT REFERENCES match(id),
  "player_id" INT REFERENCES player(id),
  "goal_time" INT,
  "own_goal" BOOLEAN DEFAULT FALSE
);

CREATE TABLE "season_standing" (
  "id" SERIAL PRIMARY KEY,
  "season_id" INT REFERENCES season(id),
  "team_id" INT REFERENCES team(id),
  "standings" INT ,
  "rankings" INT
);


INSERT INTO team (name) VALUES 
  ('team1') ,
  ('team2') ,
  ('team3');


INSERT INTO player (team_id , first_name , last_name) VALUES
  (1 , 'p1' , 'A') ,
  (2 , 'p2' , 'B') ,
  (3 , 'p3' , 'C') ,
  (1 , 'p4' , 'D') ,
  (2 , 'p5' , 'E') ,
  (3 , 'p6' , 'F') ,
  (1 , 'p7' , 'G');

INSERT INTO referee (first_name , last_name) VALUES
  ('r1' , 'H') ,
  ('r2' , 'I') ,
  ('r3' , 'J') ;

INSERT INTO season (name , start_date , end_date) VALUES
  ('2019' , '2019-10-1' , '2020-7-1'), 
  ('2020' , '2020-10-1' , '2021-7-1');


INSERT INTO match (match_date , season_id , team_1 , team_2) VALUES
  ('2019-11-1' , 1 , 1 , 2) ,
  ('2019-12-1' , 1 , 3 , 2) ,
  ('2019-12-20' , 1 , 1 , 3) ,
  ('2020-1-1' , 1 , 1 , 2) ,
  ('2020-12-1' , 2 , 2 , 3) ,
  ('2020-12-11' , 2 , 1 , 2);


INSERT INTO match_referee (match_id , referee_id , is_main_ref) VALUES
  (1 , 1 , TRUE) ,
  (1 , 2 , FALSE) ,
  (2 , 2 , TRUE) ,
  (2 , 3 , FALSE) ,
  (3 , 3 , TRUE) ,
  (3 , 1 , FALSE);


INSERT INTO goal (season_id , match_id , player_id , goal_time , own_goal) VALUES
  (1 , 1 , 1 , 120 , FALSE),
  (1 , 2 , 2 , 1200 , FALSE) ,
  (2 , 5 , 3 , 240 , FALSE);


INSERT INTO season_standing (season_id , team_id , standings , rankings) VALUES
  (1 , 1, 1 , 5) ,
  (1 , 2 , 2 , 3) ,
  (1 , 3 , 3 , 4) ,
  (2 , 1 , 1 , 5) ,
  (2 , 2 , 3 , 5) ,
  (2 , 3 , 2 , 5);