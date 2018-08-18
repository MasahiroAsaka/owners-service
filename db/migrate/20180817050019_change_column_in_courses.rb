class ChangeColumnInCourses < ActiveRecord::Migration[5.0]
  def change
    change_column :courses, :desc, :text
  end
end
