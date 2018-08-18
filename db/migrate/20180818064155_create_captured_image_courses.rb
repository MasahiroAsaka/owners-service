class CreateCapturedImageCourses < ActiveRecord::Migration[5.0]
  def change
    create_table    :captured_image_courses do |t|
      t.string      :content
      t.integer     :order
      t.references  :course, index: true
      t.timestamps
    end
  end
end
