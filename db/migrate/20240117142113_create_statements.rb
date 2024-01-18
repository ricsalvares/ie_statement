# frozen_string_literal: true

class CreateStatements < ActiveRecord::Migration[7.1]
  def change
    create_table :statements do |t|
      t.integer :disposable_income_pennies
      t.string :ie_rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
