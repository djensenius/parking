# frozen_string_literal: true

class AdminController < ApplicationController
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods
  http_basic_authenticate_with name: ENV["ADMIN_USERNAME"], password: ENV["ADMIN_PASSWORD"]
  def index
    @list = Parking.all.reverse
  end

  def destroy
    @registration = Parking.find(params[:id])
    @registration.destroy

    redirect_to admin_path
  end
end
