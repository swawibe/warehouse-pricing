Warehouse Storage Pricing API
=============================

## Create a Discount rule
You can use `target_type`, `discount_type`, `discount`, `charge_per_square_foot`, and `range_type_discount_rules_attributes` to create discounts, such as the following examples:

* The flat fee for storing a single item is $20.
* Customer A will receive a 10% discount.
* Customer B stores large items, and will be charged at $1 per square foot.
* Customer C is to be charged 5% of the value of the item being stored.
* Customer D would like a 5% discount for the first 100 items stored, 10% discount for the next 100, and 15% when they store over 200 items, and be charged at $2 per square foot.
* Customer E could receive a flat $200 discount when their monthly bill reaches $400.

### DiscountRule Properties

| Attribute   | Description                                                    |
| ----------- | -------------------------------------------------------------- |
| `name`      |  `"name": "Customer A"` <br><br>Name of a discount rule. It can be used as a customer name as well. We need this `name` later to quote storage fee |
| `target_type` |  `"target_type": "charge_on_item_price"` <br><br>It defines the characteristic of a discount rule. Currently, 5 types of characteristics are provided: <br><br>`charge_on_item_price:` Charge N`(fixed($)/percentage(%))` on the value of the item being stored. Needs to provide `item_price` field when `storage-fee` API is called <br><br>`charge_on_item_area:` Charge N`(fixed($))` on per square foot of an item. Needs to provide `item_area` field when `storage-fee` API is called <br><br>`discount_on_total_price:` Discount N`(fixed($)/percentage(%))` on flat fee. Needs to provide `flat_fee` field when `storage-fee` API is called <br><br>`bonus_after_reach:` Discount N`(fixed($)/percentage(%))` on total storage fee when it exceed certain limit. Needs to provide `flat_fee` field when `storage-fee` API is called. Otherwise, `storage-fee` will be calculated using `flat_fee = $20` |
| `discount_type`      | `"discount_type": "fixed"` <br><br>  `fixed:` Discount fixed amount from anything (`charge_on_item_price`, `charge_on_item_area`, `discount_on_total_price`, `bonus_after_reach`) <br><br>  `percentage:` Discount percentage from anything (`charge_on_item_price`, `discount_on_total_price`, `bonus_after_reach`) |
| `discount`    | `"discount_type": "5"` Amount to be discounted. It can be `fixed/percentage`. Don't need to provide any `$/%` sign  |
| `bonus_after_reaching`    | `"bonus_after_reaching": "400"` <br><br>Amount to be compared for applying discount. The `discount` field will be applied after reaching the amount provided in `bonus_after_reaching` |
| `charge_per_square_foot`    | `"charge_per_square_foot": "2"` <br><br>Amount to be charged to calculate per square foot. Needs to provide `item_area` field when storage-fee API is called |
| `range_type_discount_rules_attributes`    | `"range_type_discount_rules_attributes": [` <br>`{"items_number_from": "1", "items_number_to": "100", "discount": "10"  }`, <br>`{"items_number_from": "101", "items_number_to": "200", "discount": "15"  }`,<br>`{"items_number_from": "201", "items_number_to": "1000", "discount": "20"  }`] <br><br> Discounts the percentage from `flat_fee` according to the range. Needs to provide flat_fee field when storage-fee API is called. Otherwise, storage-fee will be calculated using `flat_fee = $20`


#### Example :
* Create a discount rules:
    <pre><code>
    Post /v1/discount-rules
    {
      "discount_rule": {
        "name": "Flat Fee",
        "target_type": "charge_on_item_price",
        "discount_type": "fixed",
        "discount": "20"
      }
    }
    </code></pre>
* Query for a warehouse storage fee (`discount_rule_name` is a `name` field from the created `discount_rule`):  
    
    <pre><code>
    GET /v1/storage-fee
    {
        "number_of_items": "10",
        "item_price": "1000",
        "discount_rule_name": "Flat Fee"
    }
    </code></pre>

#### Fetching all discount rules:

    GET /v1/discount-rules
