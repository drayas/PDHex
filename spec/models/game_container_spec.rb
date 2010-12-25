require File.dirname(__FILE__) + '/../spec_helper'

describe GameContainer do
  it 'should start out with an empty set of card ids' do
    GameContainer.new.game_card_ids.should == []
  end
end
