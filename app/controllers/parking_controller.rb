# frozen_string_literal: true

class ParkingController < ApplicationController
  def index; end

  def create
    render plain: params[:parking].inspect
  end
end
