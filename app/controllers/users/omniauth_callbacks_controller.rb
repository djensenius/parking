# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitter
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        twitter_user_persisted
      else
        session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
        redirect_to new_user_registration_url
      end
    end

    def twitter_user_persisted
      sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    end

    def facebook
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      if request.env["omniauth.auth"].info.email.blank?
        redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
        return
      end

      @user = User.from_omniauth(request.env["omniauth.auth"])
      facebook_login
    end

    def facebook_login
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication # this will throw if @user is not activated
        set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
      else
        session["devise.facebook_data"] = request.env["omniauth.auth"]
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
