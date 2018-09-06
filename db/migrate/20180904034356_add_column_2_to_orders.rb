class AddColumn2ToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :description, :text
  end
end
