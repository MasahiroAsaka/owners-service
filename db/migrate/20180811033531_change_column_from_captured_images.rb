class ChangeColumnFromCapturedImages < ActiveRecord::Migration[5.0]
  def change
    change_column :captured_images, :content, :string
  end
end
