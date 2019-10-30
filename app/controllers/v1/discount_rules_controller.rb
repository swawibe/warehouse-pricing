class V1::DiscountRulesController < ApplicationController
  before_action :set_discount_rule, only: [:show, :update, :destroy]

  # GET /discount_rules
  def index
    @discount_rules = DiscountRule.all
    render json: @discount_rules.to_json(:include => [:range_type_discount_rules])
  end

  # GET /discount_rules/1
  def show
    render json: @discount_rule.to_json(:include => [:range_type_discount_rules])
  end

  # POST /discount_rules
  def create
    @discount_rule = DiscountRule.new(discount_rule_params)

    if @discount_rule.save
      render json: @discount_rule.to_json(:include => [:range_type_discount_rules]), status: :created
    else
      render json: @discount_rule.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /discount_rules/1
  def update
    if @discount_rule.update(discount_rule_params)
      render json: @discount_rule.to_json(:include => [:range_type_discount_rules])
    else
      render json: @discount_rule.errors, status: :unprocessable_entity
    end
  end

  # DELETE /discount_rules/1
  def destroy
    @discount_rule.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_discount_rule
    @discount_rule = DiscountRule.find(params[:id])
  end

  # Only allow a trusted parameter
  def discount_rule_params
    params.fetch(:discount_rule, {}).permit(:name, :target_type, :discount_type,
                                            :discount, :bonus_after_reaching, :charge_per_square_foot,
                                            range_type_discount_rules_attributes: [:id, :items_number_from,
                                                                                   :items_number_to,
                                                                                   :discount])

  end
end
