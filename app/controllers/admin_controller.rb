# frozen_string_literal: true

class AdminController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  http_basic_authenticate_with name: "user", password: "password"

  def index
    @list = Parking.all.reverse
  end
end
