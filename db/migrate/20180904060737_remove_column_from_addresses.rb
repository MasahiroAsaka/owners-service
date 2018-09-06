class RemoveColumnFromAddresses < ActiveRecord::Migration[5.0]
  def change
    remove_column :addresses, :description, :string
  end
end
