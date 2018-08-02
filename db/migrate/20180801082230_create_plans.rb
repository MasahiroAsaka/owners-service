class CreatePlans < ActiveRecord::Migration[5.0]
  def change
    create_table :plans do |t|
      t.text      :title,                  null: false
      t.datetime  :closing_date,           null: false
      t.integer   :registration_fee,       null: false
      t.text      :text
      t.text      :content_of_service
      t.text      :benefits
      t.integer   :capacity,               null: false
      t.datetime  :wanted_period,          null: false
      t.text      :contract_period
      t.text      :plan_schedule
      t.timestamps
    end
  end
end
