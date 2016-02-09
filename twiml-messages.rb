require 'rubygems'
require 'sinatra'
require 'twilio-ruby'
 
post '/verify-phone-call' do
	content_type "text/xml"
  Twilio::TwiML::Response.new do |r|
    r.Say 'Hi, you requested to verify your phone number'
    r.Gather :numDigits => '1', :action => '/verify-phone-call/handle-gather', :method => 'post' do |g|
      g.Say 'To verify your number, press 1.'
      g.Say 'Press any other key to start over.'
  	end
  end.text
end

post '/verify-phone-call/handle-gather' do
	content_type "text/xml"
  redirect '/repeat-message' unless params['Digits'] == '1'
  Twilio::TwiML::Response.new do |r|
    r.Say 'Thank you. Your number has been verified. Goodbye.'
    #User.phone_number.verified = true 
    #user.save.
  end.text
end

get '/repeat-message' do
	content_type "text/xml"
  Twilio::TwiML::Response.new do |r|
    r.Gather :numDigits => '1', :action => '/verify-phone-call/handle-gather', :method => 'post' do |g|
      g.Say 'To verify your number, press 1.'
      g.Say 'Press any other key to start over.'
  	end
  end.text
end