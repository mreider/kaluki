require "redis"
require "date"
require "uuidtools"

class Deck
    @@redis = Redis.new
    @@card_names = ["Ace","2","3","4","5","6","7","8","9","10","Jack","Queen","King","Joker"]
    @@suits = ["hearts", "spades", "clubs", "diamonds"]

    def create(num_of_decks=1,jokers=true)
        cards = Array.new
        num_of_decks.times do
            @@card_names.each {
                |card|
                @@suits.each { |item|
                    if card != "Joker"
                        cards.push(card.capitalize + " of " + item.capitalize)
                    end
                }
            }

            if jokers == true
                cards.push("Joker","Joker")
            end
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

