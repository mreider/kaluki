require 'spec_helper'
 
describe Game do
    before(:all) do
        @game = Game.new
        @game_id = @game.create()
        @redis = Redis.new
        @player = Player.new
    end

    it "creates a new game in the database" do
        expect(@redis.hgetall(@game.create)).not_to equal(nil)
    end

    it "adds a few players to the game" do
        player_list = []
        player_names = ["Jim","Jane","Joanne","John"]
        check_player_names = []
        player_names.each {|name|
            @game.add_player(@game_id,name)
        }

        player_id_list = @game.get_player_id_list(@game_id)

        player_id_list.each { |player_id| 
            name = @player.get_player_name(player_id)
            check_player_names.push(name)
        }

        player_names_from_get_player_name_method = @game.get_player_names(@game_id)
        expect(check_player_names).to eq(player_names_from_get_player_name_method)
    end

    it "adds a deck to the game" do
        deck_id = @game.add_deck(@game_id)
        deck = Deck.new
        cards = deck.get_cards(deck_id)
        expect(cards.length).to eq(108)
    end

    it "adds three decks for more than 8 players" do
        player_names = ["five","more","players","equals","nine"]
        player_names.each {|name|
            @game.add_player(@game_id,name)
        }
        deck_id = @game.add_deck(@game_id)
        deck = Deck.new
        cards = deck.get_cards(deck_id)
        expect(cards.length).to eq(162)
    end


end