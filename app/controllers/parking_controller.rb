# frozen_string_literal: true

class ParkingController < ApplicationController
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  def index
    @parking = Parking.new
  end

  def create
    @parking = Parking.new(parking_params)
    if @parking.save
      ParkingMailer.registration(@parking).deliver_later
      redirect_to registered_path
      ParkingMailer.confirmation(@parking).deliver_later if EmailValidator.valid?(@parking[:contact])
    else
      render action: "index"
    end
  end

  def registered; end

  def terms; end

private

  def parking_params
    params.require(:parking).permit(:code, :unit, :make, :color, :license, :start_date, :end_date, :contact)
  end
end
