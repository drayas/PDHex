require File.dirname(__FILE__) + '/../spec_helper'

describe Card do
  describe 'Validations' do
    before(:each) do
      @valid_params = {
        :name      => "foo",
        :text      => "bar",
        :card_type => "baz",
        :color     => "blue"
      }
      @invalid_params = {
      }
    end # before validations

    it "Should be valid with valid params" do
      Card.new(@valid_params).valid?.should be_true
    end

    it "Should not be valid with invalid params" do
      Card.new(@invalid_params).valid?.should be_false
    end
  end # validations

  describe 'Pretty Stats' do
    before(:each) do
      @card = Card.new
    end
    it 'should show 1/1 for a 1/1 creature' do
      @card.power = @card.toughness = "1"
      @card.pretty_stats.should == "1/1"
    end
    it 'should show empty string with no power and toughness' do
      @card.pretty_stats.should == ""
    end
    it 'should show empty string if power and toughness are empty' do
      @card.power = @card.toughness = ""
      @card.pretty_stats.should == ""
    end
  end
end # main