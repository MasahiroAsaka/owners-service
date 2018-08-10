class Model < ActiveRecord::Migration[5.0]
  def change
    create_table :captured_images do |t|
      t.text        :content, null: false
      t.string      :status, null: false
      t.integer     :order
      t.references   :plan, index: true
    end
  end
end
