# frozen_string_literal: true

class Parking < ApplicationRecord
  validates :unit, presence: true, numericality: { only_integer: true }
  validates :code, presence: true
  validates :make, presence: true
  validates :color, presence: true
  validates :license, presence: true
  validates :nights, presence: true, numericality: { only_integer: true }
end
