class AddColumn3ToOrders < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :address, index: true
  end
end
