class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env['omniauth.auth'])
    if @user.persisted? 
      sign_in_and_redirect root_path
      flash[:notice] = 'You have successfully logged in.'
    else
      flash[:error] = 'Login Failed.'
    end
  end
end