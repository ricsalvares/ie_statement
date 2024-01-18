# frozen_string_literal: true

class Statement < ApplicationRecord
  belongs_to :user
  has_many :statement_items, dependent: :destroy
  accepts_nested_attributes_for :statement_items

  # validations
  validates :user, presence: true

  # scopes
  scope :by_user, ->(user) { where(user:) }
end
