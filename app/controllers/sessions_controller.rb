class SessionsController < ApplicationController

  def create
  
    user = User.from_omniauth(env["omniauth.auth"])
    if user.present?
      session[:user_id] = user.id 
      $data = env["omniauth.auth"].extra.access_token
    end
    redirect_to root_path

  end



  def destroy
     session[:user_id] = nil
    redirect_to root_url

  end
end
