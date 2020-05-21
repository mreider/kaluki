require 'spec_helper'
 
describe Hand do
    before(:all) do
        @player = Player.new
        @game = Game.new
        @game_id = game.create()
        @deck = Deck.new
        @deck_id = @deck.create(2)
        @game.add_deck(deck_id)
        @player_id = @player.create("bob")
        @hand = hand.new
        @hand_id = @hand.create(@player_id,@game_id,11)
        @redis = Redis.new
    end

    it "gives bob 11 cards" do
        expect(@hand.get_cards.to eq(11)
        expect(@hand.get_player_id.to eq(@player_id))
    end

end