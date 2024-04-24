
--question 1
--Richard Boysen 


local function releaseStorage(player)
    player:setStorageValue(1000, 1) -- Fixed logic issue, changed -1 to 1
end

--Program was attempting to release player storage when a player logs out if value = 1, but the value was negative. 
--I assigned 1 as a default value 

function onLogout(player)
    if player:getStorageValue(1000) == 1 then
        addEvent(releaseStorage, 1000, player)
    end
    return true
end
