class AddColumnsToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :lat, :string
    add_column :plans, :lng, :string
  end
end
