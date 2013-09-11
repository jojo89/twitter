get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)
   @user = User.create(:username => @access_token.params[:screen_name] ,:oauth_token =>@access_token.token , :oauth_secret => @access_token.secret)
  # at this point in the code is where you'll need to create your user account and store the access token

  session[:id]= @user.id
 
  erb :index
 
end

get '/status/:job_id' do


  job_status = job_is_complete(params[:job_id])
 
  # content_type: "json"
  {status: job_status}.to_json

  # find(params[:job_id])
  # if request.xhr?
  #   erb :index, layout: false
  # else
  #   erb :index
  #   @error = "Your tweet wasn't posted"
  # end
end


post '/tweet' do

  user  = User.find(session[:id])

  Twitter.configure do |config|
    config.oauth_token = user.oauth_token
    config.oauth_token_secret = user.oauth_secret
  end
   @status = user.tweet(params[:tweet])


  # @tweet = Twitter.update(params[:tweet])
 # redirect to "/status/#{@status.id}"

end



