function printSmallGuildNames(memberCount)
    -- This method prints names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < ?;"
    --resultID was redundant, as it was assigned the result of db.storeQuery, which is never used
    --changed ro local result 
    local result = db.storeQuery(selectGuildQuery, memberCount)

    --added error handling 
    if not result then
        print("Failed to execute query.")
        return
    end

    --added a while loop to iterate over the result set 
    while result:next() do
        local guildName = result:getString("name")
        print(guildName)
    end

    result:free()
end
--In this version:

--I've used a parameterized query to prevent SQL injection vulnerabilities.
--The result:next() function is used to iterate over each row in the result set.
--The result:free() function is called to free the result set after processing it.