class AddColumnToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :sum, :integer, null: false, default: 0
  end
end
