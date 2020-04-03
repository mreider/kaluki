require 'spec_helper'
 
describe Deck do
    before(:all) do
        @deck = Deck.new(2) #two decks
        @redis = Redis.new
    end

    it "creates 108 (includes jokers) cards for two decks" do
        expect(@deck.cards.length).to eq(108)
    end

    it "has 108 cards in the database" do
        @deck.create
        cards = @redis.lrange(@deck.deck_id,0,-1)
        expect(cards.length).to eq(108)
    end

    it "takes a valid card out of the deck" do
        @deck.pick_card(@deck.deck_id)
        expect(@deck.cards.include?(@deck.picked_card)).to eq(true)
    end

    it "has one less card in the database" do
        cards = @redis.lrange(@deck.deck_id,0,-1)
        expect(cards.length).to eq(107) 
    end

    it "has no cards after destroying the deck" do
        @deck.destroy(@deck.deck_id)
        expect(@redis.llen(@deck.deck_id)).to eq(0)
    end
end