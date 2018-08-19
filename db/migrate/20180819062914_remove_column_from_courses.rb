class RemoveColumnFromCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :image
  end
end
