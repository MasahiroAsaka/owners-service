class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string     :name,        null: false
      t.string     :zip_code_1,  null: false
      t.string     :zip_code_2,  null: false
      t.string     :state,       null: false
      t.string     :address_1,   null: false
      t.string     :address_2,   null: false
      t.string     :tel,         null: false
      t.text       :description
      t.references :owner,       index: true
      t.timestamps
    end
  end
end
