# frozen_string_literal: true

module Services
  class CreateStatement
    def initialize(user:, items: [])
      @user = user
    end

    def call
      statement.save
      statement
    end

    private

    attr_reader :user

    def statement
      @statement ||= Statement.new(**params)
    end

    def params
      { user_id: user.id }
    end
  end
end
