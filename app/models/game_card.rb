class GameCard < ActiveRecord::Base
  belongs_to :game_deck
  belongs_to :card
  validate :visibility_must_be_valid

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

  VISIBILITY_TYPES = %w(player all)

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
  def handle_action(options = {})
    container = options[:container]
    code = options[:code]
    case code
      when 'graveyard'
        game_card_ids = container.game_card_ids
        game_card_ids.delete_at(game_card_ids.find_index(self.id))
        container.update_attribute(:game_card_ids, game_card_ids)
        graveyard = self.game_deck.graveyard
        graveyard.update_attribute(:game_card_ids, graveyard.game_card_ids.push(self.id))
      else
        return [false, "You specified an undefined action code: #{code.inspect}"]
    end
    return [true, ""]
  end

  def visible?(user)
    return true if self.visibility == "all"
    return true if self.game_deck.game_user.user == user
    return false
  end

  def visibility_must_be_valid
    if self.visibility.nil? || !VISIBILITY_TYPES.include?(self.visibility.downcase)
      self.errors.add_to_base("Invalid visibility type")
      return false
    end
    return true
  end
end
