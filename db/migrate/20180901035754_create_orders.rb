class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :owner,  index: true
      t.integer     :course_id_list
      t.integer    :course_count_list
      t.timestamps
    end
  end
end
