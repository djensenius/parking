# frozen_string_literal: true

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
  scope :past, -> { where("end_date <= ?", Date.today) }
end
