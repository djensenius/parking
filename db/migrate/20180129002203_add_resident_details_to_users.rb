# frozen_string_literal: true

class AddResidentDetailsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :unit, :int
    add_column :users, :name, :string
    add_column :users, :contact, :string
    add_column :users, :code, :string
  end
end
