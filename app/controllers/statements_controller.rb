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
    @statement.statement_items.build
  end

  def edit; end

  def create
    @statement = Services::CreateStatement.new(user: current_user, items: items_params).call

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

  def items_params
    statement_params[:statement_items_attributes]
      .to_h
      .with_indifferent_access
      .map { |_, i| i }
  end

  def statement_params
    params
      .require(:statement)
      .permit(statement_items_attributes: %i[name amount_pennies statement_type])
  end
end
