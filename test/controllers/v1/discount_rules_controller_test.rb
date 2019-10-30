require 'test_helper'

class V1::DiscountRulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @discount_rule = discount_rules(:one)
  end

  test "should get index" do
    get v1_discount_rules_url, as: :json
    assert_response :success
  end

  test "should create discount_rule" do
    assert_difference('DiscountRule.count') do
      post v1_discount_rules_url, params: {discount_rule: {}}, as: :json
    end

    assert_response 201
  end

  test "should show discount_rule" do
    get v1_discount_rule_url(@discount_rule), as: :json
    assert_response :success
  end

  test "should update discount_rule" do
    patch v1_discount_rule_url(@discount_rule), params: {discount_rule: {}}, as: :json
    assert_response 200
  end

  test "should destroy discount_rule" do
    assert_difference('DiscountRule.count', -1) do
      delete v1_discount_rule_url(@discount_rule), as: :json
    end

    assert_response 204
  end
end
