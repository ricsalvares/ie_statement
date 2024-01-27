class Api::V1::StatementsController < ApplicationController
  
  def index
    @statements = Statement.by_user(current_user)
    render json: @statements
  end

  def create
  end

  def show
    @statement = Statement.joins(:statement_items).includes(:statement_items)
    render json: @statement, include: [statement_items: {only: [:name, :amount_pennies, :statement_type]}]
  end

  def update    
  end

  def destroy
  end

  def recipe_params
    params.permit(:name, :image, :ingredients, :instruction)
  end
end
