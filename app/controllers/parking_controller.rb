# frozen_string_literal: true

class ParkingController < ApplicationController
  protect_from_forgery with: :exception

  def index
    @parking = Parking.new
  end

  def create
    @parking = Parking.new(parking_params)
    if @parking.save
      redirect_to registered_path
    else
      render action: "index"
    end
  end

  def registered; end

private

  def parking_params
    params.require(:parking).permit(:code, :unit, :make, :color, :license, :nights)
  end
end
