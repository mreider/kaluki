require "redis"
require "date"

class Player
    attr_reader :player_id
    @@redis = Redis.new
    def initialize(name)
        t = DateTime
        @player_id = t.now.strftime("%Y%m%d%k%M%S%L").to_i.to_s(36)
        @@redis.set(@player_id,name)
        return
    end

    def get_player_name(player_id)
        name = @@redis.get(@player_id)
        return name
    end

    def destroy(player_id)
        @@redis.del(player_id)
        return true
    end

end