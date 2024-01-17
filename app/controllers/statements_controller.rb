# frozen_string_literal: true

class StatementsController < ApplicationController
  def index
    @statements = Statement.by_user(current_user)
  end

  def show; end

  def new; end

  def edit; end

  def create; end

  def update; end

  def destroy; end

  private

  def statement_params
    params.require(:statement).permit
  end
end
