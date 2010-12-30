class GameCard < ActiveRecord::Base
  belongs_to :game_deck
  belongs_to :card

  # Parameter requirements:
  # :none, :number, :target, :number_and_target, :name_and_target
  ACTIONS = {
    :graveyard            => {:param_required => :none,               :display => "Send to graveyard"},
    :remove               => {:param_required => :none,               :display => "Remove card from the game"},
    :play                 => {:param_required => :target,             :display => "Play this card"},
    :draw                 => {:param_required => :number_and_target,  :display => "Draw card(s)"},
    :tap                  => {:param_required => :none,               :display => "Tap this card"},
    :add_counter          => {:param_required => :number,             :display => "Add counter(s)"},
    :remove_counter       => {:param_required => :number,             :display => "Remove counter(s)"},
    :deck_bottom          => {:param_required => :none,               :display => "Put this card at the bottom of your deck"},
    :deck_top             => {:param_required => :none,               :display => "Put this card at the top of your deck"},
    :deck_fetch           => {:param_required => :name_and_target,    :display => "Fetch a card from your deck"},
    :graveyard_fetch      => {:param_required => :name_and_target,    :display => "Fetch a card from your graveyard"}
  }
  # return an array of hashes with an action code and display name:
  # [
  #   {:code => 'to_graveyard', :name => 'Send to graveyard'},
  #   {:code => 'from_game',    :name => 'Remove card from the game'}
  # ]
  def action_list(container)
    case container.name
      when 'hand'
        return format_actions([
          :graveyard,
          :remove,
          :play,
          :deck_bottom,
          :deck_top
        ])
      when 'in_play'
    end
    return []
  end
  def format_actions(actions)
    actions.map{|code| {:code => code, :display => ACTIONS[code][:display], :param_required => ACTIONS[code][:param_required]}}
  end

  def move(from, to)
    game_card_ids = from.game_card_ids
    game_card_ids.delete_at(game_card_ids.find_index(self.id))
    from.update_attribute(:game_card_ids, game_card_ids)
    to.update_attribute(:game_card_ids, to.game_card_ids.push(self.id))
  end

  def handle_action(options = {})
    container = options[:container]
    code = options[:code]
    case code
      when 'graveyard'
        self.move(container, self.game_deck.graveyard)
      else
        return [false, "You specified an undefined action code: #{code.inspect}"]
    end
    return [true, ""]
  end
end
