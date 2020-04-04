# kaluki
Kaluki / Jamaican rummy / contract

## Class list

### Game

|  method | parameters | returns    | description                                                                       | 
|------------|---------|------------|-----------------------------------------------------------------------------------|
| create             | (none)  | game_id    | Creates a game and inserts into redis with a unique ID                    | 
| add_player         | name    | true       | Adds a player to the game, inserts new player into redis and associates   |
| get_player_id_list | game_id    | player_id_list       | retrieves the list of player id's from redis                    |
| get_player_names | game_id    | name_list       | retrieves the list of player names from redis                    |
| add_deck | game_id    | deck_id       | creates a deck with either 108 or 162 cards (more than 8 players)            |
| destroy | game_id    | deck_id       | creates a deck with either 108 or 162 cards (more than 8 players)            |

### Deck

|  method | parameters | returns    | description                                                                       | 
|------------|---------|------------|-----------------------------------------------------------------------------------|
| create             | num_of_decks  | deck_id    | Creates a deck with either 54 * num_of_decks and insterts into redis              | 
| get_cards        | deck_id    | cards       | Returns array of shuffled cards                                |
| pick_card | deck_id    | picked_card      | gets a card from the deck and removes from redis                   |
| destroy | deck_id    | true      | removes the deck from redis                   |

### Player

|  method | parameters | returns    | description                                                                       | 
|------------|---------|------------|-----------------------------------------------------------------------------------|
| create             | name  | player_id    | Creates a player and insterts into redis              | 
| get_player_name        | player_id    | name       | Returns the name of a player                                |
| destroy | player_id    | true      | removes the player from redis                   |


