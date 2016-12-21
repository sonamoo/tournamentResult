-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.

CREATE TABLE players (id SERIAL PRIMARY KEY, name TEXT);

CREATE TABLE matches (id SERIAL PRIMARY KEY, 
					  winner INTEGER REFERENCES players(id),
					  loser INTEGER REFERENCES plyaers(id));
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


