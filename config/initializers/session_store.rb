# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hex_session',
  :secret      => '4da25821c08eee77dce403688312d0f74725b93a093050200bf03e4e1e7544537a86b50920702e201d200644ca99f4073bbe4a505ba6c5e5f7d4448ac19c3aa7'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
