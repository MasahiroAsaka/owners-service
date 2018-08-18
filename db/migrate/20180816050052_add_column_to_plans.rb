class AddColumnToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :main_image, :string
  end
end
