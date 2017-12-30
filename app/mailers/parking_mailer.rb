# frozen_string_literal: true

class ParkingMailer < ApplicationMailer
  def registration(parking)
    @parking = parking
    mail(to: ENV["EMAIL"], subject: I18n.t("email.subject"))
  end
end
