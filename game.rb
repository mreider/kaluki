require "redis"
require "date"
require "./deck.rb"
require "./player.rb"

class Game
    attr_reader :game_id
    attr_reader :player_id_list
    attr_reader :player_names
    @@redis = Redis.new
    def initialize()
        t = DateTime
        @game_id = t.now.strftime("%Y%m%d%k%M%S%L").to_i.to_s(36)
        @@redis.hset(@game_id,"start",t.now.strftime("%b%e, %l:%M %p"))
        return
    end
    
    def add_player_to_game(game_id,name)
       player = Player.new(name)
       @player_id_list.push(player.player_id)
       @@redis.hset(@game_id,"player_id_list",@player_id_list)
       return
    end

    def get_player_id_list(game_id)
        @player_id_list = @@redis.hget(@game_id,"player_id_list")
        return
    end

    def get_player_names(game_id)
        get_player_id_list(game_id)
        @player_id_list.each {|player_id|
            @player_names.push(plaher.get_player_name(player_id))
        }
        return
    end

end