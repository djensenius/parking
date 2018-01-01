# frozen_string_literal: true

class AddContactToParkings < ActiveRecord::Migration[5.1]
  def change
    add_column :parkings, :contact, :string
  end
end
