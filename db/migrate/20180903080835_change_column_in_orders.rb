class ChangeColumnInOrders < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :course_id_list, :string
    change_column :orders, :course_count_list, :string
  end
end
