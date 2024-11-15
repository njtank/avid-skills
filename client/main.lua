-- avid-skills client/main.lua
RegisterNetEvent('avid-skills:updateUI')
AddEventHandler('avid-skills:updateUI', function(skillTime, skillType)
    if skillType == "stamina" then
        SendNUIMessage({
            type = "updateSkillUI",
            skills = { stamina = skillTime }
        })
    elseif skillType == "driving" then
        SendNUIMessage({
            type = "updateSkillUI",
            skills = { driving = skillTime }
        })
    elseif skillType == "shooting" then
        SendNUIMessage({
            type = "updateSkillUI",
            skills = { shooting = skillTime }
        })
    end
end)

-- Open Skill Menu with Radial
RegisterNetEvent('avid-skills:openSkillMenu')
AddEventHandler('avid-skills:openSkillMenu', function()
    -- Add code to open radial menu for checking skills
end)
