class CreateCapturedImages < ActiveRecord::Migration[5.0]
  def change
    create_table :captured_images do |t|
      t.text :content, null: false
      t.integer :status, null: false
      t.integer :order, null: false
      t.references :plan, index: true
      t.timestamps
    end
  end
end
