require 'bundler'
Bundler.require
# require 'twilio-ruby' 
require 'giphy'

class ApplicationController < Sinatra::Base

  account_sid = 'ACaa0a2ceb8411bb4aa9348dc3d00558f0' 
  auth_token = '373c5b9d1d7c5bd7a9dc2cce087b0dcd'

  get '/' do
    erb :index
  end

  post '/result' do
    @keyword = params[:keyword]
    @number = params[:number]
    @random_gif = Giphy.random(@keyword).image_original_url

    @client = Twilio::REST::Client.new account_sid, auth_token 
 
    @client.account.messages.create({ 
        :to => @number,
        :body => @greeting, 
        :media_url => @random_gif,
        :from => "+19283251586"
    })
    
    erb :result
  end 

end
