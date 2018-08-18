class ChangeColumnFromPlans < ActiveRecord::Migration[5.0]
  def change
    remove_column :plans, :etc
  end
end
