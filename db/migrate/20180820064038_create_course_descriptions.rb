class CreateCourseDescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :course_descriptions do |t|
      t.text        :content, null: false
      t.references  :course,  index: true
      t.timestamps
    end
  end
end
