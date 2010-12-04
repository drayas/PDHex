module DummyData
  # Like mock_model basically, but with defaults and some more association help
  def generate_dummy_account(options = {})
    account = Account.new
    account.stub!(:id).and_return(1)
    Account.stub!(:find).and_return(account)

		account.stub!(:uses_flat_rate_shipping?	).and_return(options[:uses_flat_rate_shipping] 	|| nil)
		account.stub!(:is_free_trial?						).and_return(options[:is_free_trial?] 					|| false)
    account.stub!(:subdomain).and_return(options[:subdomain] 	|| "dummysubdomain")
		# stub associations
		account.stub!(:locale		).and_return(options[:locale]			|| locale = generate_dummy_locale)
    account.stub!(:franchise).and_return(options[:franchise] 	|| generate_dummy_franchise(:locale => locale))

    account
  end

end
