class RemoveColumnToPlans < ActiveRecord::Migration[5.0]
  def change
    remove_column :plans, :main_image
  end
end
