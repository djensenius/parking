# frozen_string_literal: true

class CreateParkings < ActiveRecord::Migration[5.1]
  def change
    create_table :parkings do |t|
      t.string :code
      t.integer :unit
      t.string :make
      t.string :color
      t.string :license
      t.integer :nights

      t.timestamps
    end
  end
end
