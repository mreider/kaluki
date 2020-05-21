require 'spec_helper'
 
describe Flipped do
    before(:all) do
        @game = Game.new
        @game_id = @game.create
        @redis = Redis.new
    end

    it "has three sets of flipped cards" do
        expect(@redis.get(@player_id)).to eq(nil)
    end
end