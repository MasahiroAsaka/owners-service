class ChangeColumnmodalInPlans < ActiveRecord::Migration[5.0]
  def change
    change_column :plans, :registration_fee, :string
    change_column :plans, :closing_date_month, :string
    change_column :plans, :closing_date_day, :string
  end
end
