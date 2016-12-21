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
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

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