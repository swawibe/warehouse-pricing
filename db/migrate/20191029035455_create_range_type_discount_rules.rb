class CreateRangeTypeDiscountRules < ActiveRecord::Migration[5.2]
  def change
    create_table :range_type_discount_rules do |t|
      t.integer :items_number_from
      t.integer :items_number_to
      t.float :discount
      t.references :discount_rule
      t.timestamps
    end
  end
end
