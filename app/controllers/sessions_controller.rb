class SessionsController < ApplicationController

  def create
   # binding.pry
    user = User.from_omniauth(env["omniauth.auth"])
   
    session[:user_id] = user.id 
    $data = env["omniauth.auth"].extra.access_token
    #binding.pry
    redirect_to root_url

  end



  def destroy
     session[:user_id] = nil
    redirect_to root_url

  end
end
