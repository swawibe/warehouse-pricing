class V1::ItemPricesController < ApplicationController

  # GET /v1/storage-fee
  def storage_fee
    if params[:discount_rule_name].nil?
      render json: 'Please provide discount_rule_name', status: :unprocessable_entity
      return
    end

    @discount_rule = DiscountRule.find_by(name: params[:discount_rule_name])
    unless @discount_rule
      render json: 'Please provide correct discount_rule_name', status: :unprocessable_entity
      return
    end

    fees, message = @discount_rule.calculate_storage_fee(params)

    if fees
      render json: "Warehouse storage fees: #{fees}", status: :ok
    else
      render json: message, status: :unprocessable_entity
    end
  end
end
