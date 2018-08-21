class RemoveColumn2FromCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :desc
  end
end
