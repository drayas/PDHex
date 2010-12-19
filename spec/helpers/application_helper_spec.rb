require File.dirname(__FILE__) + '/../spec_helper'
require File.dirname(__FILE__) + '/../../app/helpers/application_helper.rb'
include ApplicationHelper

describe ApplicationHelper do
  
  describe 'Rendering costs' do
    before(:each) do
      @supported_tokens = %w(R r B U G W T)
    end
    it 'should not fail with nil' do
      ApplicationHelper::render_cost(nil)
    end
    it 'should support the following tokens' do
      @supported_tokens.each do |tok|
        str = "a string with token -#{tok}- should change"
        ApplicationHelper.render_cost(str).should_not == str
      end
    end
    it 'should not change a normal string' do
      str = "this is a normal string.  It can have a dash - so long as there are spaces between the - and the chars."
      ApplicationHelper.render_cost(str).should == str
    end
    it 'should handle two of the same token in a row' do
      one = "-R-"
      two = "-RR-"
      ApplicationHelper.render_cost(one).should_not == ApplicationHelper.render_cost(two)

    end
  end

end # main describe