class ChangeColumnInPlans < ActiveRecord::Migration[5.0]
  def change
    change_column :plans, :lat, :string
    change_column :plans, :lng, :string
  end
end
