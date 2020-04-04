require "redis"
require "date"
require "uuidtools"

class Deck
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
        "Jack" => {:points => 10, :order => [11]},
        "Queen" => {:points => 10, :order => [12]},
        "King" => {:points => 10, :order => [13]},
        "Joker" => {:points => 15, :order => [0..15]}
    }
    @@suits = ["hearts", "spades", "clubs", "diamonds"]
    @@red_suits = ["hearts", "diamonds"]
    def create(num_of_decks=1)
        cards = Array.new
        num_of_decks.times do
            @@card_metadata.each {
                |k,v|
                @@suits.each { |item|
                    if k != "Joker"
                        cards.push(k.capitalize + " of " + item.capitalize)
                    end
                }
            }
            cards.push("Joker","Joker")
        end
        cards = cards.shuffle
        # brew services start redis
        deck_id = UUIDTools::UUID.timestamp_create
        @@redis.lpush(deck_id,cards)
        return deck_id
    end

    def get_cards(deck_id)
        cards = Array.new
        cards = @@redis.lrange(deck_id,0,-1)
        return cards
    end

    def pick_card(deck_id)
        picked_card = @@redis.lpop(deck_id)
        return picked_card
    end
    def destroy(deck_id)
        @@redis.del(deck_id)
        return true
    end
end

