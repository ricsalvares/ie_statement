# frozen_string_literal: true

module Api
  module V1
    class StatementsController < ApplicationController
      before_action :load_statement, only: %i[show update destroy]

      def index
        @statements = Statement.by_user(current_user)
        render json: @statements
      end

      def create
        statement = Services::CreateStatement.new(user: current_user, items: items_params).call

        if statement&.persisted?
          load_statement(statement.id)
          render json: @statement, include: [statement_items: { only: %i[name amount_pennies statement_type] }]
        else
          render json: statement.errors
        end
      end

      def show
        render json: @statement, include: [statement_items: { only: %i[name amount_pennies statement_type id] }]
      end

      def update
        statement = Services::UpdateStatement.new(statement: @statement, user: current_user, items: items_params).call

        respond_to do |_format|
          if statement.errors.empty?
            load_statement(statement.id)
            render json: @statement,
                   include: [statement_items: { only: %i[name amount_pennies statement_type id] }]
          else
            render json: statement.errors
          end
        end
      end

      def destroy
        @statement&.destroy
        render json: { message: 'Statement deleted!' }
      end

      private

      def load_statement(id = nil)
        @statement = Statement.by_user(current_user)
                              .joins(:statement_items)
                              .includes(:statement_items)
                              .find(id || params[:id])
      end

      def items_params
        statement_params[:items]
      end

      def statement_params
        params
          .require(:statement)
          .permit(items: %i[name amount_pennies statement_type _destroy id])
      end
    end
  end
end
