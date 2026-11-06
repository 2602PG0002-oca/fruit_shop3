class AddProductAndUserToOrders < ActiveRecord::Migration[8.1]
  def change
    add_reference :orders, :product, null: false, foreign_key: true
    add_reference :orders, :user, null: false, foreign_key: true
  end
end
