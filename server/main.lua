-- avid-skills server/main.lua
RegisterServerEvent('avid-skills:incrementStamina')
AddEventHandler('avid-skills:incrementStamina', function(playerId)
    -- Logic for stamina tracking
    MySQL.Async.fetchScalar('SELECT stamina_time FROM player_skills WHERE player_id = @id', {
        ['@id'] = playerId
    }, function(staminaTime)
        local newTime = (staminaTime or 0) + 1
        MySQL.Async.execute('UPDATE player_skills SET stamina_time = @time WHERE player_id = @id', {
            ['@time'] = newTime,
            ['@id'] = playerId
        })

        -- Check for rewards
        TriggerEvent('avid-skills:checkRewards', playerId, "stamina", newTime)
    end)
end)

RegisterServerEvent('avid-skills:incrementDriving')
AddEventHandler('avid-skills:incrementDriving', function(playerId)
    -- Logic for driving tracking
    MySQL.Async.fetchScalar('SELECT driving_time FROM player_skills WHERE player_id = @id', {
        ['@id'] = playerId
    }, function(drivingTime)
        local newTime = (drivingTime or 0) + 1
        MySQL.Async.execute('UPDATE player_skills SET driving_time = @time WHERE player_id = @id', {
            ['@time'] = newTime,
            ['@id'] = playerId
        })

        -- Check for rewards
        TriggerEvent('avid-skills:checkRewards', playerId, "driving", newTime)
    end)
end)

RegisterServerEvent('avid-skills:incrementShooting')
AddEventHandler('avid-skills:incrementShooting', function(playerId)
    -- Logic for shooting tracking
    MySQL.Async.fetchScalar('SELECT shooting_time FROM player_skills WHERE player_id = @id', {
        ['@id'] = playerId
    }, function(shootingTime)
        local newTime = (shootingTime or 0) + 1
        MySQL.Async.execute('UPDATE player_skills SET shooting_time = @time WHERE player_id = @id', {
            ['@time'] = newTime,
            ['@id'] = playerId
        })

        -- Check for rewards
        TriggerEvent('avid-skills:checkRewards', playerId, "shooting", newTime)
    end)
end)

RegisterServerEvent('avid-skills:checkRewards')
AddEventHandler('avid-skills:checkRewards', function(playerId, skillType, currentTime)
    -- Check rewards based on the config thresholds
    for _, level in ipairs(Config.RewardLevels) do
        if currentTime >= level.level then
            -- Check if player has already received the reward
            MySQL.Async.fetchScalar('SELECT reward_given FROM player_skills WHERE player_id = @id', {
                ['@id'] = playerId
            }, function(rewardGiven)
                if not rewardGiven then
                    -- Give the reward box via ox_inventory
                    TriggerEvent('ox_inventory:addItem', playerId, level.item, 1)
                    MySQL.Async.execute('UPDATE player_skills SET reward_given = 1 WHERE player_id = @id', {
                        ['@id'] = playerId
                    })
                    TriggerClientEvent('chat:addMessage', playerId, { args = { "Skill Reward", level.message } })
                end
            end)
        end
    end
end)
