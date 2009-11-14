# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gr-parks-givecamp_session',
  :secret      => '63e3bb513235f4e1b91deae116e711bd77e5c98b6bcb67d75a1980ea9a38a21e4b89867b0578b868441386db16efb78d5b177210e999cba3159580207c4e67fb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
