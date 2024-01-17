# frozen_string_literal: true

class StatementsController < ApplicationController
  def index
    @statements = Statement.where(user_id: current_user.id)
  end
end
