# frozen_string_literal: true

class AddStartAndEndDateToParkings < ActiveRecord::Migration[5.1]
  def change
    add_column :parkings, :start_date, :date
    add_column :parkings, :end_date, :date
    remove_column :parkings, :nights
  end
end
