--new name, now a function to remove from party
function removePlayerFromParty(playerId, memberName)
    local player = Player(playerId)
    local party = player:getParty()

    local members = party:getMembers()

    --iteration over the party members
    for _, member in ipairs(members) do
        if member:getName() == memberName then --comparison between name of the party member with the memberName
            party:removeMember(member)
            return true  -- Assuming we want to stop after removing one member
        end
    end

    return false  -- Indicate whether the member was found and removed
end
