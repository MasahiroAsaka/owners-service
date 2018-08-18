class ChangeColumnFromPlans < ActiveRecord::Migration[5.0]
  def change
    remove_column :plans, :closing_date
    remove_column :plans, :text
    remove_column :plans, :content_of_service
    remove_column :plans, :benefits
    remove_column :plans, :capacity
    remove_column :plans, :contract_period
    add_column    :plans, :shop_name,           :text,   null: false
    add_column    :plans, :place,               :text,   null: false
    add_column    :plans, :closing_date_month,  :string, null: false
    add_column    :plans, :closing_date_day,    :string, null: false
    add_column    :plans, :contents,            :text,   null: false
    add_column    :plans, :plan_detail,         :text,   null: false
  end
end
