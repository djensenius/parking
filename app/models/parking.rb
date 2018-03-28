# frozen_string_literal: true

require "csv"

class Parking < ApplicationRecord
  validates :unit, presence: true, numericality: { only_integer: true }
  validates :code, presence: true
  validates :make, presence: true
  validates :color, presence: true
  validates :license, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :contact, presence: true

  scope :today, -> { where("start_date <= ? AND end_date >= ?", Date.today, Date.today) }
  scope :future, -> { where("start_date > ?", Date.today) }
  scope :past, -> { where("end_date <= ?", Date.today).order("start_date desc") }

  def self.to_csv
    attributes = ["id", "unit", "code", "make", "color", "license", "contact", "created_at", "start_date", "end_date"]

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |p|
        csv << attributes.map { |attr| p.send(attr) }
      end
    end
  end
end
