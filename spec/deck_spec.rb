require 'spec_helper'
 
describe Deck do
    before(:all) do
        @redis = Redis.new
        @deck = Deck.new
        @deck_id = @deck.create(2)
    end

    it "creates 108 (includes jokers) cards for two decks" do
        cards = @deck.get_cards(@deck_id)
        expect(cards.length).to eq(108)
    end

    it "takes a valid card out of the deck" do
        suits = ["Hearts", "Spades", "Clubs", "Diamonds"]
        its_a_card = false
        picked_card = @deck.pick_card(@deck_id)
        suits.each { |item|
                    if picked_card.include? item
                        its_a_card = true
                    end
        }
        expect(its_a_card).to eq(true)
    end

    it "has one less card in the database" do
        cards = @redis.lrange(@deck_id,0,-1)
        expect(cards.length).to eq(107) 
    end

    it "has no cards after destroying the deck" do
        @deck.destroy(@deck_id)
        expect(@redis.llen(@deck_id)).to eq(0)
    end
end