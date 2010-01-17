# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_webapp_session',
  :secret      => '1329cc6d9f24ae881b6bc72a28147dcaf20e6f9fdafa845022794dbba7d92607b6bd997e86c1cbd54899955d21fcd15e54ffc854627b6e665269d29d1167f722'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
