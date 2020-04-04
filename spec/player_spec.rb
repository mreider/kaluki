require 'spec_helper'
 
describe Player do
    before(:all) do
        @player = Player.new
        @player_id = @player.create("bob")
        @redis = Redis.new
    end

    it "creates a new player and saves to the database" do
        expect(@player.get_player_name(@player_id)).to eq("bob")
    end

    it "has no player in the database after he is destroyed" do
        @player.destroy(@player_id)
        expect(@redis.get(@player_id)).to eq(nil)
    end
end