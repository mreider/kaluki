require "redis"
require "date"

class Deck
    attr_reader :cards
    attr_reader :deck_id
    attr_reader :picked_card
    @@redis = Redis.new
    @@card_metadata = {
        "Ace" => {:points => 15, :order => [1,14]},
        "2" => {:points => 2, :order => [2]},
        "3" => {:points => 3, :order => [3]},
        "4" => {:points => 4, :order => [4]},
        "5" => {:points => 5, :order => [5]},
        "6" => {:points => 6, :order => [6]},
        "7" => {:points => 7, :order => [7]},
        "8" => {:points => 8, :order => [8]},
        "9" => {:points => 9, :order => [9]},
        "10" => {:points => 10, :order => [10]},
        "Jack" => {:points => 15, :order => [11]},
        "Queen" => {:points => 15, :order => [12]},
        "King" => {:points => 15, :order => [13]},
        "Joker" => {:points => 15, :order => [0..15]}
    }
    @@suits = ["hearts", "spades", "clubs", "diamonds"]
    @@red_suits = ["hearts", "diamonds"]

    def initialize(num_of_decks=1)
        @cards = []
        num_of_decks.times do
            @@card_metadata.each {
                |k,v|
                @@suits.each { |item|
                    if k != "Joker"
                        @cards.push(k.capitalize + " of " + item.capitalize)
                    end
                }
            }
            @cards.push("Joker","Joker")
        end
        @cards = @cards.shuffle
        return true
    end
    def create()
        # brew services start redis
        t = DateTime
        @deck_id = t.now.strftime("%Y%m%d%k%M%S%L").to_i.to_s(36)
        @@redis.lpush(@deck_id,@cards)
        return true
    end
    def pick_card(deck_id)
        @picked_card = @@redis.lpop(deck_id)
        return true
    end
    def destroy(deck_id)
        @@redis.del(deck_id)
        return true
    end
end

