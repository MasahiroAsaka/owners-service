class ChangeColumnFromPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :etc, :text
    remove_column :plans, :wanted_period
  end
end
