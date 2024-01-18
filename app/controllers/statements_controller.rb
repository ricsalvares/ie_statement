# frozen_string_literal: true

class StatementsController < ApplicationController
  before_action :load_statement, only: %i[show edit update destroy]

  def index
    @statements = Statement.by_user(current_user)
  end

  def show; end

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

  def update
    @statement = Services::UpdateStatement.new(statement: @statement, user: current_user, items: items_params).call

    respond_to do |format|
      if @statement.errors.empty?
        format.html do
          redirect_to statement_path(@statement), notice: 'Statement has been successfully updated.'
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @statement.destroy!
    respond_to do |format|
      format.html do
        redirect_to statements_path, notice: 'Statement has been successfully destroyed.'
      end
    end
  end

  private

  def load_statement
    @statement = Statement.by_user(current_user).find(params[:id])
  end

  def items_params
    statement_params[:statement_items_attributes]
      .to_h
      .with_indifferent_access
      .map { |_, i| i }
      .compact
  end

  def statement_params
    params
      .require(:statement)
      .permit(statement_items_attributes: %i[name amount_pennies statement_type id _destroy])
  end
end
