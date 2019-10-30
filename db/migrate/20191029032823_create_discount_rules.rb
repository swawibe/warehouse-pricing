class CreateDiscountRules < ActiveRecord::Migration[5.2]
  def change
    create_table :discount_rules do |t|
      t.string :name
      t.integer :target_type
      t.integer :discount_type
      t.float :discount
      t.float :bonus_after_reaching
      t.float :charge_per_square_foot
      t.timestamps
    end
  end
end
