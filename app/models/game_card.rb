class GameCard < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :game_deck
  belongs_to :card
  validate :visibility_must_be_valid
  serialize :counters, Hash

  # Parameter requirements:
  # :none, :number, :target, :number_and_target, :name_and_target
  ACTIONS = {
    :graveyard            => {:param_required => :none,               :display => "Send to graveyard"},
    :remove               => {:param_required => :none,               :display => "Remove card from the game"},
    :play                 => {:param_required => :none,               :display => "Play this card"},
    :hand                 => {:param_required => :none,               :display => "Move this card to your hand"},
    :draw                 => {:param_required => :number_and_target,  :display => "Draw card(s)"},
    :tap                  => {:param_required => :none,               :display => "Tap this card"},
    :add_counter          => {:param_required => :number,             :display => "Add counter(s)"},
    :remove_counter       => {:param_required => :number,             :display => "Remove counter(s)"},
    :deck_bottom          => {:param_required => :none,               :display => "Put this card at the bottom of your deck"},
    :add_to_stack         => {:param_required => :none,               :display => "Add this card to the stack"},
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
        return format_actions([
          :tap,
          :add_to_stack,
          :graveyard,
          :hand,
          :remove,
          :deck_bottom,
          :deck_top,
          :add_counter,
          :remove_counter
        ])
    end
    return []
  end
  def format_actions(actions)
    actions = actions.map{|code| {:code => code, :display => ACTIONS[code][:display], :param_required => ACTIONS[code][:param_required]}}
    # Update tap situation (show "Untap" if we're already tapped)
    tap_action = actions.select{|hash| hash[:code] == :tap}.first
    tap_action[:display] = "Untap" if tap_action && self.is_tapped?
    actions
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
      when 'hand'
        self.move(container, self.game_deck.hand)
      when 'graveyard'
        self.move(container, self.game_deck.graveyard)
      when 'removed'
        self.move(container, self.game_deck.removed)
      when 'deck_top'
        self.move(container, self.game_deck.library)
      when 'deck_bottom'
        self.move(container, self.game_deck.library)
      when 'play'
        self.move(container, self.game_deck.in_play)
      when 'tap'
        self.update_attribute(:is_tapped, !self.is_tapped?)
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

  def display_text(container = nil)
    container_name = container.nil? ? "" : container.name
    text = self.card.name.titlecase
    text += " (T)" if self.is_tapped?
    text += " #{pretty_stats_helper(self.power, self.toughness)}" if container_name == "in_play"
    text += " #{render_cost(self.card.cost)}" if container_name == "hand"
    text
  end
end
