# frozen_string_literal: true

class Statement < ApplicationRecord
  belongs_to :user

  # validations
  validates :user, presence: true

  # scopes
  scope :by_user, ->(user) { where(user:) }
end
