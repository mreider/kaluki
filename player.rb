require "redis"
require "date"
require "uuidtools"

class Player
    @@redis = Redis.new
    def create(name)
        player_id = UUIDTools::UUID.timestamp_create
        @@redis.set(player_id,name)
        return player_id
    end

    def get_player_name(player_id)
        name = @@redis.get(player_id)
        return name
    end

    def destroy(player_id)
        @@redis.del(player_id)
        return true
    end

end