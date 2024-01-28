class Api::V1::StatementsController < ApplicationController
  
  def index
    @statements = Statement.by_user(current_user)
    render json: @statements
  end

  def create
    statement = Services::CreateStatement.new(user: current_user, items: items_params).call

    if statement&.persisted?
      @statement = Statement.joins(:statement_items).includes(:statement_items).find(statement.id)
      render json: @statement, include: [statement_items: {only: [:name, :amount_pennies, :statement_type]}]
    else
      render json: statement.errors
    end
  end

  def show
    @statement = Statement.joins(:statement_items).includes(:statement_items).find(params[:id])
    render json: @statement, include: [statement_items: {only: [:name, :amount_pennies, :statement_type, :id]}]
  end

  def update
  end

  def destroy
    binding.pry
  end


  private

  def items_params
    statement_params[:items]
  end

  def statement_params
    params
      .require(:statement)
      .permit(items: [:name, :amount_pennies, :statement_type, :_destroy, :id])
  end
end
