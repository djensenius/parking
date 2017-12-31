# frozen_string_literal: true

class AdminController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
  def index
    @list = Parking.all.reverse
  end
end
