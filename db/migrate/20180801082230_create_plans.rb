class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.text      :title,               null: false
      t.integer   :registration_fee,    null: false
      t.string    :shop_name,           null: false
      t.string    :place,               null: false
      t.string    :closing_date_month,  null: false
      t.string    :closing_date_day,    null: false
      t.text      :contents,            null: false
      t.text      :plan_detail,         null: false
      t.timestamps
    end
  end
end
