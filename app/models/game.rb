class Game < ActiveRecord::Base
  has_many :game_users
  has_many :users, :through => :game_users

  # Players is an array of hashes with user_ids and deck_ids
  #[
  #  {:user => u, :deck => d},
  #  {:user => u2, :deck => d1}
  #]
  def self.test
    Game.start!([{:user => User.first, :deck => Deck.last}, {:user => User.last, :deck => Deck.last}])
  end

  def self.start!(players)
    # Guard clauses
    raise "Bad data structure!" unless players.is_a?(Array) && players.first.is_a?(Hash)
    raise "Games require more than one player!" if players.size < 2

    # Create our game
    game = Game.create!
    # We need to create game_decks for each player
    

    user_names = []
    players.each { |player|
      raise "I need a player and deck for every player!" unless player[:user] && player[:deck]
      game_user = GameUser.create!(
        :game    => game,
        :user => player[:user]
      )
      user_names << player[:user].name
      game_deck = GameDeck.create!(
        :game_user => game_user,
        :deck => player[:deck]
      )
      game_deck.prepare!
    }
    game.update_attribute(:name, "Game between #{user_names.join(" and ")}")

    game
  end
end
