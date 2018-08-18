class ChangeCoulmnInCources < ActiveRecord::Migration[5.0]
  def change
    add_reference :courses, :plan, index: true
  end
end
