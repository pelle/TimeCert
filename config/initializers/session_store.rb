# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_timecert_session',
  :secret      => '13c9832d4bed30c731296746bb0c1fa02b5f03706520296e2b5f3bb48e3633494ebc58fcf26a0e8fcf1686d1b088d140346cccfb37cd53d51843719712e4e009'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
