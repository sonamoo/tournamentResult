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


CREATE VIEW view_wins as 
SELECT players.id as player, count(players.name) as wins
FROM players, matches 
WHERE players.id = matches.winner
GROUP BY players.id
ORDER BY wins desc;

CREATE VIEW view_loses as
SELECT players.id as player, count(players.name) as loses
FROM players, matches
WHERE players.id = matches.loser
GROUP BY players.id
ORDER BY loses desc;

CREATE VIEW view_matches as
SELECT players.id as player, count(matches) as matches
FROM players LEFT JOIN matches
ON (players.id = matches.winner) OR (players.id = matches.loser)
GROUP BY players.id
ORDER BY players.id ASC;
