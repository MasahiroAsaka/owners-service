class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :price
      t.string :desc
      t.string :image
      t.timestamps
    end
  end
end
