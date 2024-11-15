# avid-skills

`avid-skills` is a FiveM resource that tracks player skills in three areas: Stamina, Shooting, and Driving. Players earn rewards as they progress in these skills over time. This script integrates with `ox_inventory` to provide reward items and allows players to check their skill progression through an in-game UI and radial menu.

## Features

- Tracks **Stamina**, **Shooting**, and **Driving** skills.
- Provides rewards (e.g., `reward_box`) when players reach specific skill milestones.
- Integrates with `ox_inventory` to provide in-game rewards.
- Configurable thresholds for skill progression and rewards.
- UI for players to check their current skill levels.
- SQL integration to store skill data and rewards in a MySQL database.

## Installation

1. **Download the Resource**
   - Download the `avid-skills` folder and place it in your server's `resources` directory.

2. **Add to Server Configuration**
   - Open your `server.cfg` and add the following line to ensure the script is loaded:
     ```
     ensure avid-skills
     ```

3. **Set Up MySQL Database**
   - Execute the provided `create_tables.sql` script in your MySQL database to set up the necessary tables for storing player skill data.
     ```sql
     -- SQL to create player skills table
     CREATE TABLE IF NOT EXISTS player_skills (
         player_id INT NOT NULL PRIMARY KEY,
         stamina_time INT DEFAULT 0,
         driving_time INT DEFAULT 0,
         shooting_time INT DEFAULT 0,
         reward_given BOOLEAN DEFAULT FALSE
     );

     -- Add indexes to improve performance on queries
     CREATE INDEX IF NOT EXISTS idx_player_skills_id ON player_skills(player_id);
     ```

4. **Configure the Resource**
   - Open `config.lua` and adjust the following settings:
     - `Config.SkillThresholds`: Set the minimum time in minutes required for players to progress in each skill area (Stamina, Driving, Shooting).
     - `Config.RewardLevels`: Define the skill level milestones and corresponding rewards. Each level specifies a threshold time, item to be rewarded, and a message to notify the player.

5. **Ensure MySQL Integration**
   - Make sure you have `mysql-async` or another compatible MySQL resource installed and configured for your server. This will allow the script to save and retrieve player data.

## Usage

### Skill Tracking

- **Stamina**: Earned by running or swimming. The player’s time will increase as they engage in these activities.
- **Shooting**: Earned by firing weapons. The more the player shoots, the higher their shooting skill will become.
- **Driving**: Earned by driving at high speeds. The player’s driving time increases as they exceed a certain speed.

### Rewards

Players will be given a `reward_box` when they reach specific skill milestones, as configured in `Config.RewardLevels`. The reward will be given through `ox_inventory`, and a message will notify the player about the reward.

### Checking Skills

- Players can check their current skill progress through a custom UI, which displays the skill levels for Stamina, Shooting, and Driving.
- The skill progress can also be checked via a radial menu event that opens the UI.

- **Events **:  
  ```lua
  TriggerEvent('avid-skills:incrementStamina', playerId)
  TriggerEvent('avid-skills:incrementDriving', playerId)
  TriggerEvent('avid-skills:incrementShooting', playerId)
  TriggerEvent('avid-skills:checkRewards', playerId, "stamina", currentStaminaTime)
