class AddColumnsToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :shop_name, :string, null: false
    add_column :plans, :partner_message, :text, null: false
    add_column :plans, :place, :string, null: false
    add_column :plans, :closing_date_month, :integer, null: false
    add_column :plans, :closing_date_day, :integer, null: false
    remove_column :plans, :closing_date
  end
end
