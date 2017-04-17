-- tables
-- Table: Stats
CREATE TABLE Stats (
    stat_id bigint NOT NULL,
    year int NOT NULL,
    nfl_player_id bigint NOT NULL,
    nfl_team_id int NOT NULL,
    position varchar(4),
    defense_ast real NOT NULL,
    defense_ffum real NOT NULL,
    defense_int real NOT NULL,
    defense_sk real NOT NULL,
    defense_tkl real NOT NULL,
    fumbles_lost real NOT NULL,
    fumbles_rcv real NOT NULL,
    fumbles_tot real NOT NULL,
    fumbles_trcv real NOT NULL,
    fumbles_yds real NOT NULL,
    kicking_fga real NOT NULL,
    kicking_fgm real NOT NULL,
    kicking_fgyds real NOT NULL,
    kicking_totpfg real NOT NULL,
    kicking_xpa real NOT NULL,
    kicking_xpb real NOT NULL,
    kicking_xpmade real NOT NULL,
    kicking_xpmissed real NOT NULL,
    kicking_xptot real NOT NULL,
    kickret_avg real NOT NULL,
    kickret_lng real NOT NULL,
    kickret_lngtd real NOT NULL,
    kickret_ret real NOT NULL,
    kickret_tds real NOT NULL,
    passing_att real NOT NULL,
    passing_cmp real NOT NULL,
    passing_ints real NOT NULL,
    passing_tds real NOT NULL,
    passing_twopta real NOT NULL,
    passing_twoptm real NOT NULL,
    passing_yds real NOT NULL,
    punting_avg real NOT NULL,
    punting_i20 real NOT NULL,
    punting_lng real NOT NULL,
    punting_pts real NOT NULL,
    punting_yds real NOT NULL,
    puntret_avg real NOT NULL,
    puntret_lng real NOT NULL,
    puntret_lngtd real NOT NULL,
    puntret_ret real NOT NULL,
    puntret_tds real NOT NULL,
    receiving_lng real NOT NULL,
    receiving_lngtd real NOT NULL,
    receiving_rec real NOT NULL,
    receiving_tds real NOT NULL,
    receiving_twopta real NOT NULL,
    receiving_twoptm real NOT NULL,
    receiving_yds real NOT NULL,
    rushing_att real NOT NULL,
    rushing_lng real NOT NULL,
    rushing_lngtd real NOT NULL,
    rushing_tds real NOT NULL,
    rushing_twopta real NOT NULL,
    rushing_twoptm real NOT NULL,
    rushing_yds real NOT NULL,
    nfl_team_nfl_team_id bigint NOT NULL,
    revised_nfl_players_nfl_player_id bigint NOT NULL,
    CONSTRAINT Stats_pk PRIMARY KEY (stat_id)
);

-- Table: fantasy_player
CREATE TABLE fantasy_player (
    fantasy_id bigint NOT NULL,
    email varchar(64) NOT NULL,
    password varchar(64) NOT NULL,
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
    CONSTRAINT fantasy_team_id PRIMARY KEY (fantasy_team_id, player_id)
) COMMENT 'This table holds the fantasy team for the fantasy player.';

-- Table: nfl_players
CREATE TABLE nfl_players (
    nfl_player_id bigint NOT NULL,
    name varchar(64) NOT NULL,
    nfl_team_id int NOT NULL,
    fantasy_team_id int,
    fantasy_team_fantasy_team_id bigint,
    nfl_team_nfl_team_id bigint NOT NULL,
    CONSTRAINT nfl_players_pk PRIMARY KEY (nfl_player_id)
);

-- Table: nfl_team
CREATE TABLE nfl_team (
    nfl_team_id bigint NOT NULL,
    team_name varchar(64) NOT NULL,
    city varchar(64) NOT NULL,
    abbreviation varchar(4) NOT NULL,
    CONSTRAINT nfl_team_pk PRIMARY KEY (nfl_team_id)
);

-- foreign keys
-- Reference: Stats_nfl_team (table: Stats)
ALTER TABLE Stats ADD CONSTRAINT Stats_nfl_team FOREIGN KEY Stats_nfl_team (nfl_team_nfl_team_id)
    REFERENCES nfl_team (nfl_team_id)
    ON DELETE CASCADE;

-- Reference: Stats_revised_nfl_players (table: Stats)
ALTER TABLE Stats ADD CONSTRAINT Stats_revised_nfl_players FOREIGN KEY Stats_revised_nfl_players (revised_nfl_players_nfl_player_id)
    REFERENCES nfl_players (nfl_player_id)
    ON DELETE CASCADE;

-- Reference: fantasy_team_fantasy_player (table: fantasy_team)
ALTER TABLE fantasy_team ADD CONSTRAINT fantasy_team_fantasy_player FOREIGN KEY fantasy_team_fantasy_player (fantasy_player_fantasy_id)
    REFERENCES fantasy_player (fantasy_id)
    ON DELETE CASCADE;

-- Reference: revised_nfl_players_fantasy_team (table: nfl_players)
ALTER TABLE nfl_players ADD CONSTRAINT revised_nfl_players_fantasy_team FOREIGN KEY revised_nfl_players_fantasy_team (fantasy_team_fantasy_team_id)
    REFERENCES fantasy_team (fantasy_team_id)
    ON DELETE CASCADE;

-- Reference: revised_nfl_players_nfl_team (table: nfl_players)
ALTER TABLE nfl_players ADD CONSTRAINT revised_nfl_players_nfl_team FOREIGN KEY revised_nfl_players_nfl_team (nfl_team_nfl_team_id)
    REFERENCES nfl_team (nfl_team_id)
    ON DELETE CASCADE;


-- End of file.
