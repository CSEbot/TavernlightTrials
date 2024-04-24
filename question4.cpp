
/*We introduced a boolean variable playerCreated to track whether the player was created within this method.
If the player was created within this method (playerCreated is true), we delete the player object at appropriate points to avoid memory leaks.
We deallocate memory for the player when loading or item creation fails to ensure proper cleanup.*/

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    bool playerCreated = false;

    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // Deallocate memory for the player if loading failed
            return;
        }
        playerCreated = true;
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (playerCreated) {
            delete player; // Deallocate memory for the player if item creation failed and player was created in this method
        }
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    if (playerCreated) {
        delete player; // Deallocate memory for the player if it was created in this method
    }
}
