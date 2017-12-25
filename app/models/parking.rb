# frozen_string_literal: true

class Parking < ApplicationRecord
  validates_presence_of :code, :unit, :make
end
