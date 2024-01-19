# frozen_string_literal: true

module Services
  module Concerns
    module ParamByItem
      def param_by_item(item)
        {
          name: item[:name],
          statement_type: item[:statement_type].to_i,
          amount_pennies: item.fetch(:amount_pennies, 0).to_f * 100 # converts into pennies
        }
      end
    end
  end
end
