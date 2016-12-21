-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
DROP DATABASE IF EXISTS tournament;
CREATE DATABASE tournament;
\connect tournament;

CREATE TABLE players (id SERIAL PRIMARY KEY, name TEXT);

CREATE TABLE matches (id SERIAL PRIMARY KEY, 
					  winner INTEGER REFERENCES players(id),
					  loser INTEGER REFERENCES players(id));


-- Insert players 
INSERT INTO players(name) values('Baby Octopus');
INSERT INTO players(name) values('Lion');
INSERT INTO players(name) values('Tiger');
INSERT INTO players(name) values('Fish');
INSERT INTO players(name) values('Rabbit');
INSERT INTO players(name) values('Squirrel');
INSERT INTO players(name) values('Chipmunk');
INSERT INTO players(name) values('Sparrow');

-- Insert maches
INSERT INTO matches(winner, loser) values(1, 2);
INSERT INTO matches(winner, loser) values(3, 4);
INSERT INTO matches(winner, loser) values(5, 6);
INSERT INTO matches(winner, loser) values(7, 8);
INSERT INTO matches(winner, loser) values(2, 1);
INSERT INTO matches(winner, loser) values(4, 3);
INSERT INTO matches(winner, loser) values(6, 5);
INSERT INTO matches(winner, loser) values(8, 7);
INSERT INTO matches(winner, loser) values(1, 3);
INSERT INTO matches(winner, loser) values(5, 8);
INSERT INTO matches(winner, loser) values(4, 6);
INSERT INTO matches(winner, loser) values(2, 7);


CREATE VIEW win_total as 
select players.name, count(players.name) as win_total
from players, matches 
where players.id = matches.winner
group by players.name
order by win_total desc;

CREATE VIEW lose_total as
select players.name, count(players.name) as lose_total
from players, matches
where players.id = matches.loser
group by players.name
order by lose_total desc;


