require "redis"
require "date"
require "uuidtools"
require 'json'
require "./deck.rb"
require "./player.rb"

class Game
    @@redis = Redis.new
    def create()
        t = DateTime
        game_id = UUIDTools::UUID.timestamp_create
        @@redis.hset(game_id,"start",t.now.strftime("%b%e, %l:%M %p"))
        return game_id 
    end
    
    def add_player(game_id,name)
       player = Player.new
       player_id = player.create(name)
       player_id_list = get_player_id_list(game_id)
       player_id_list.push(player_id)
       @@redis.hset(game_id,"player_id_list",player_id_list.to_json)
       return
    end

    def get_player_id_list(game_id)
        temp = @@redis.hget(game_id,"player_id_list")
        player_id_list = Array.new
        if (!temp.nil?)
            player_id_list = JSON.parse(temp)
        end
        return player_id_list
    end

    def get_player_names(game_id)
        player = Player.new
        player_names = Array.new
        player_id_list = get_player_id_list(game_id)
        player_id_list.each {|player_id|
            player_names.push(player.get_player_name(player_id))
        }
        return player_names
    end

    def add_deck(game_id)
        deck = Deck.new
        if get_player_names(game_id).length > 8
            deck_id = deck.create(3)
        else
            deck_id = deck.create(2)
        end
        @@redis.hset(game_id,"deck_id",deck_id)
        return deck_id
    end

    def destroy(game_id)
        @@redis.del(game_id)
        return true
    end

end