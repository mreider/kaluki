require 'spec_helper'
 
describe Game do
    before(:all) do
        @game = Game.new
        @redis = Redis.new
    end

    it "creates a new game in the database" do
        expect(@redis.hgetall(@game.game_id)).not_to equal(nil)
    end
end