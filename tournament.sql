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

CREATE VIEW view_wins AS 
SELECT players.id AS player, count(matches.winner) AS wins
FROM players LEFT JOIN matches 
ON players.id = matches.winner
GROUP BY players.id
ORDER BY wins desc;

CREATE VIEW view_loses AS
SELECT players.id AS player, count(matches.loser) AS loses
FROM players LEFT JOIN matches
ON players.id = matches.loser
GROUP BY players.id
ORDER BY loses desc;

CREATE VIEW view_matches AS
SELECT players.id AS player, count(matches) AS matches
FROM players LEFT JOIN matches
ON (players.id = matches.winner) OR (players.id = matches.loser)
GROUP BY players.id
ORDER BY players.id ASC;

CREATE VIEW view_standings AS
SELECT players.id, players.name, view_wins.wins, view_matches.matches
FROM players
LEFT JOIN view_wins ON players.id = view_wins.player
LEFT JOIN view_matches ON players.id = view_matches.player
GROUP BY players.id, players.name, view_wins.wins, view_matches.matches
ORDER BY view_wins.wins DESC;