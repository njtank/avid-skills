CREATE TABLE IF NOT EXISTS player_skills (
    player_id INT NOT NULL PRIMARY KEY,
    stamina_time INT DEFAULT 0,
    driving_time INT DEFAULT 0,
    shooting_time INT DEFAULT 0,
    reward_given BOOLEAN DEFAULT FALSE
);

CREATE INDEX IF NOT EXISTS idx_player_skills_id ON player_skills(player_id);
