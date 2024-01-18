# frozen_string_literal: true

class CreateStatementItems < ActiveRecord::Migration[7.1]
  def change
    create_table :statement_items do |t|
      t.references :statement, null: false, foreign_key: true
      t.string :name
      t.integer :statement_type, null: false
      t.integer :amount_pennies

      t.timestamps
    end
    add_index :statement_items, :statement_type
  end
end
