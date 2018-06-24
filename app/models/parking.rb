# frozen_string_literal: true

require "csv"

class DateValidator < ActiveModel::Validator
  def validate(record)
    return if record.end_date.nil? || record.start_date.nil?
    if record&.end_date&.month != record&.start_date&.month
      multiple_months(record)
    else
      month(record)
    end
  end

  def month(record)
    if (record&.end_date - record&.start_date).to_i > 5
      record.errors[:base] << I18n.t("errors.too_long")
    end
  end

  def multiple_months(record)
    if record.end_date.month - record.start_date.month > 1 
      record.errors[:base] << I18n.t("errors.too_long")
    elsif Time.days_in_month(record.start_date.month, record.start_date.year) - record.start_date.day > 5
      record.errors[:base] << I18n.t("errors.too_long")
    elsif record.end_date.day > 5
      record.errors[:base] << I18n.t("errors.too_long")
    end
  end
end

class Parking < ApplicationRecord
  validates :unit, presence: true, numericality: { only_integer: true }
  validates :code, presence: true
  validates :make, presence: true
  validates :color, presence: true
  validates :license, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :contact, presence: true
  validates_with DateValidator

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
