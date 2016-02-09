require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'
 
# put your own credentials here - from twilio.com/user/account
account_sid = 'xxyy'
auth_token = 'xxyy'
 
# set up a client to talk to the Twilio REST API
@client = Twilio::REST::Client.new account_sid, auth_token
 
@call = @client.account.calls.create(
  :from => '+1123',   # From your Twilio number
  :to => '+1123',     # To any number
  # Fetch instructions from this URL when the call connects
  :url => 'ngrok/verify-phone-call'
)


