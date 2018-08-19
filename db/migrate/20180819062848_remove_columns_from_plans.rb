class RemoveColumnsFromPlans < ActiveRecord::Migration[5.0]
  def change
    remove_column :plans, :index_image
    remove_column :plans, :title_image
  end
end
