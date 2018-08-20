class AddColumnsToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :card_desc_summary, :text
  end
end
