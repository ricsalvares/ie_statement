# frozen_string_literal: true

class StatementsController < ApplicationController
  def index
    @statements = Statement.by_user(current_user)
  end

  def show
    @statement = Statement.by_user(current_user).find(params[:id])
  end

  def new
    @statement = Statement.new
  end

  def edit; end

  def create
    @statement = Services::CreateStatement.new(user: current_user).call

    respond_to do |format|
      if @statement.persisted?
        format.html do
          redirect_to statement_path(@statement), notice: 'Statement has been successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update; end

  def destroy
    statement = Statement.by_user(current_user).find(params[:id])
    statement.destroy!
    respond_to do |format|
      format.html do
        redirect_to statements_path, notice: 'Statement has been successfully created.'
      end
    end
  end

  private

  def statement_params
    params.require(:statement).permit
  end
end
