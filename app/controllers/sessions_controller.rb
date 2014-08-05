class SessionsController < ApplicationController
  @testData  = ""
  def create
  
    user = User.from_omniauth(env["omniauth.auth"])
    if user.present?
      session[:user_id] = user.id 
      $data = env["omniauth.auth"].extra.access_token
      # @testData = $data
    end
    binding.pry
    redirect_to  root_path
    # respond_to do |format|
    #     format.html
    #     format.json { redirect_to :root_path(data: @data) }
    # end

  end



  def destroy
     session[:user_id] = nil
    redirect_to root_url

  end
end
