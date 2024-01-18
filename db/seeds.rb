# frozen_string_literal: true
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Running seeds..."
User.create(email: "test2@test.com", password: '12341234')
user = User.create(email: "test@test.com", password: '12341234')

items = [
  {
    'name': 'Salary',
    'statement_type': 1,
    'amount': 12_300
  },
  {
    'name': 'Found on the ground',
    'statement_type': 1,
    'amount': 100
  },
  {
    'name': 'pay back borrowed money',
    'statement_type': 0,
    'amount': 15
  },
  {
    'name': 'Groceries',
    'statement_type': 0,
    'amount': 123.94
  }
]
::Services::CreateStatement.new(user: user, items: items).call