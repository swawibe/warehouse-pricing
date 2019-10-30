class DiscountRule < ApplicationRecord
  # ----------------------------------------------------------------------
  # == Include Modules == #
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # == Constants == #
  # ----------------------------------------------------------------------

  enum target_type: [:charge_on_item_price, :charge_on_item_area, :discount_on_total_price, :bonus_after_reach,
                     :discount_on_number_of_items]
  enum discount_type: [:fixed, :percentage]

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

  validates :discount, allow_blank: true, numericality: {only_float: true}
  validates :bonus_after_reaching, allow_blank: true, numericality: {only_float: true}
  validates :charge_per_square_foot, allow_blank: true, numericality: {only_float: true}
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

  # ----------------------------------------------------------------------
  # == Class methods == #
  # ----------------------------------------------------------------------

end
