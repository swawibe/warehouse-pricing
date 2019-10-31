class DiscountRule < ApplicationRecord
  # ----------------------------------------------------------------------
  # == Include Modules == #
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # == Constants == #
  # ----------------------------------------------------------------------

  enum target_type: { charge_on_item_price: 0, charge_on_item_area: 1, discount_on_total_price: 2, bonus_after_reach: 3,
                      discount_on_number_of_items: 4 }

  enum discount_type: { fixed: 0, percentage: 1 }

  # ----------------------------------------------------------------------
  # == Attributes == #
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # == File Uploader == #
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # == Associations and Nested Attributes == #
  # ----------------------------------------------------------------------

  has_many :range_type_discount_rules, dependent: :destroy

  # Range type table should not be generated if 'range_type_discount_rules' from JSON input is an empty
  accepts_nested_attributes_for :range_type_discount_rules, allow_destroy: true, reject_if: :all_blank


  # ----------------------------------------------------------------------
  # == Validations == #
  # ----------------------------------------------------------------------

  validates :discount, allow_blank: true, numericality: { only_float: true }
  validates :bonus_after_reaching, allow_blank: true, numericality: { only_float: true }
  validates :charge_per_square_foot, allow_blank: true, numericality: { only_float: true }
  validates :name, uniqueness: true

  # ----------------------------------------------------------------------
  # == Callbacks == #
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # == Scopes and Other macros == #
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # == Instance methods == #
  # ----------------------------------------------------------------------

  def calculate_storage_fee(params)
    requested_target_type = DiscountRule.target_types[self.target_type]
    fixed_discount_type = DiscountRule.discount_types[:fixed]
    number_of_items = params[:number_of_items].present? ? params[:number_of_items].to_f : 1
    flat_fee = params[:flat_fee].present? ? params[:flat_fee].to_f : 20
    discount = self.discount.to_f

    if requested_target_type == DiscountRule.target_types[:charge_on_item_price]
      if params[:item_price].nil?
        return [nil, "Please provide item_price"]
      end

      if DiscountRule.target_types[discount_type] == fixed_discount_type
        # Requirement 1: Charge flat_fee x$ on each item
        return discount * number_of_items
      else
        # Requirement 4: Charge x% of the value of the item being stored
        return (discount * params[:item_price].to_f * number_of_items) / 100
      end

    elsif requested_target_type == DiscountRule.target_types[:charge_on_item_area]
      if params[:item_area].nil?
        return [nil, "Please provide item_area"]
      end

      if DiscountRule.target_types[discount_type] == fixed_discount_type
        # Requirement 3: Charge x$ on per square foot
        return discount * params[:item_area].to_f * number_of_items
        # else
        # New feature: Charge x% on per square foot
        # return (discount * params[:item_area].to_f) / 100
      end

      # Returns total storage fee after giving a discount on flat fees
    elsif requested_target_type == DiscountRule.target_types[:discount_on_total_price]
      if DiscountRule.target_types[discount_type] == fixed_discount_type
        # New feature: Discount x$ on flat fee
        discounted_flat_fee = flat_fee - discount
        return discounted_flat_fee * number_of_items
      else
        # Requirement 2: Discount x% on flat fee
        # Assuming Customer will get x% discount on flat fees (it could be on total price as well.
        # In that case, a customer needs to provide item_price)
        total_fee = flat_fee * number_of_items
        return (total_fee - ((total_fee * discount) / 100))
      end

      # Returns total storage fee after giving a discount on total storage fee when it exceed certain limit
    elsif requested_target_type == DiscountRule.target_types[:bonus_after_reach]
      total_fee = flat_fee * number_of_items

      if total_fee >= bonus_after_reaching
        if DiscountRule.target_types[discount_type] == fixed_discount_type
          # Bonus: Discount x$ on total fee when it exceed certain limit
          return total_fee - discount
        else
          # New feature: Discount x% on total fee when it exceed certain limit
          return (total_fee - ((total_fee * discount) / 100))
        end
      else
        return [nil, "Bill Didn't reach $#{bonus_after_reaching} yet"]
      end

    elsif requested_target_type == DiscountRule.target_types[:discount_on_number_of_items]
      if params[:number_of_items].nil?
        return [nil, "Please provide number_of_items"]
      end

      range_discount_rules = self.range_type_discount_rules.group(:items_number_from)
      number_of_items = params[:number_of_items].to_i || 0
      total_fee = 0

      range_discount_rules.each do |range_discount_rule|
        items_to_calculate = [range_discount_rule.items_number_to, number_of_items].min
        temp_fee = flat_fee * items_to_calculate
        total_fee += (temp_fee - ((temp_fee * range_discount_rule.discount) / 100))
        number_of_items -= items_to_calculate
        break if number_of_items <= 0
      end
      return total_fee

    else
      return [nil, "Could not find any target_type that you requested"]
    end

  end

  # ----------------------------------------------------------------------
  # == Class methods == #
  # ----------------------------------------------------------------------

end
