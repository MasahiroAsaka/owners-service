class AddColumnsToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :title_image, :text
    add_column :plans, :index_image, :text
  end
end
