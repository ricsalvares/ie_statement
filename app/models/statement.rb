# frozen_string_literal: true

class Statement < ApplicationRecord
  belongs_to :user

  # validations
  validates :user, presence: true
end
