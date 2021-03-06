class RangeTypeDiscountRule < ApplicationRecord
  # ----------------------------------------------------------------------
  # == Include Modules == #
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # == Constants == #
  # ----------------------------------------------------------------------


  # ----------------------------------------------------------------------
  # == Attributes == #
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # == File Uploader == #
  # ----------------------------------------------------------------------

  # ----------------------------------------------------------------------
  # == Associations and Nested Attributes == #
  # ----------------------------------------------------------------------

  belongs_to :discount_rule

  # ----------------------------------------------------------------------
  # == Validations == #
  # ----------------------------------------------------------------------

  validates :discount_rule, presence: true

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
