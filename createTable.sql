
-- tables
-- Table: fantasy_player
CREATE TABLE fantasy_player (
    fantasy_id bigint NOT NULL,
    email varchar(64) NOT NULL,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    fantasy_team_id bigint NOT NULL,
    CONSTRAINT fantasy_id PRIMARY KEY (fantasy_id)
) COMMENT 'This table holds the fantasy players.';

CREATE INDEX fantasy_player_idx_1 ON fantasy_player (fantasy_id);

-- Table: fantasy_team
CREATE TABLE fantasy_team (
    fantasy_team_id bigint NOT NULL,
    team_name varchar(64) NOT NULL,
    player_id bigint NOT NULL,
    fantasy_player_fantasy_id bigint NOT NULL,
    CONSTRAINT fantasy_team_id PRIMARY KEY (fantasy_team_id)
) COMMENT 'This table holds the fantasy team for the fantasy player.';

-- Table: nfl_players
CREATE TABLE nfl_players (
    nfl_player_id bigint NOT NULL,
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    position_id bigint NOT NULL,
    nfl_team_id bigint NOT NULL,
    nfl_team_nfl_team_id bigint NOT NULL,
    fantasy_team_fantasy_team_id bigint NOT NULL,
    CONSTRAINT nfl_players_pk PRIMARY KEY (nfl_player_id)
) COMMENT 'This table holds the NFL Players that belong to a fantasy team.';

-- Table: nfl_team
CREATE TABLE nfl_team (
    nfl_team_id bigint NOT NULL,
    team_name varchar(64) NOT NULL,
    city varchar(64) NOT NULL,
    CONSTRAINT nfl_team_pk PRIMARY KEY (nfl_team_id)
);

-- Table: player_position
CREATE TABLE player_position (
    player_position_id int NOT NULL,
    position varchar(64) NOT NULL,
    nfl_players_nfl_player_id bigint NOT NULL,
    CONSTRAINT player_position_pk PRIMARY KEY (player_position_id)
) COMMENT 'This holds the positions a nfl player has.';

-- foreign keys
-- Reference: fantasy_team_fantasy_player (table: fantasy_team)
ALTER TABLE fantasy_team ADD CONSTRAINT fantasy_team_fantasy_player FOREIGN KEY fantasy_team_fantasy_player (fantasy_player_fantasy_id)
    REFERENCES fantasy_player (fantasy_id);

-- Reference: nfl_players_fantasy_team (table: nfl_players)
ALTER TABLE nfl_players ADD CONSTRAINT nfl_players_fantasy_team FOREIGN KEY nfl_players_fantasy_team (fantasy_team_fantasy_team_id)
    REFERENCES fantasy_team (fantasy_team_id);

-- Reference: nfl_players_nfl_team (table: nfl_players)
ALTER TABLE nfl_players ADD CONSTRAINT nfl_players_nfl_team FOREIGN KEY nfl_players_nfl_team (nfl_team_nfl_team_id)
    REFERENCES nfl_team (nfl_team_id);

-- Reference: player_position_nfl_players (table: player_position)
ALTER TABLE player_position ADD CONSTRAINT player_position_nfl_players FOREIGN KEY player_position_nfl_players (nfl_players_nfl_player_id)
    REFERENCES nfl_players (nfl_player_id);

-- End of file.

