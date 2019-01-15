class Users::OmniauthCallbacksController < ApplicationController
  
  def facebook
    @user = User.create_form_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user 
    else
      flash[:alert] = 'There was problem signing you in through Facebook. Please register or try signing in later.'
      redirect_to new_user_registration_path
    end
  end

  def google_oauth2
    @user = User.create_form_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
    else
      flash[:alert] = 'There was a problem signing you in through Google. Please register or try signing in later.'
      redirect_to new_user_registration_path
    end
  end

  def failure
    flash[:alert] = 'There was a problem signing you in. Please register of try signing in later.'
    redirect_to new_user_registration_path
  end

end
