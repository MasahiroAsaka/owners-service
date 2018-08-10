class AddAdminToOwners < ActiveRecord::Migration[5.0]
  def change
    add_column :owners, :admin, :boolean
  end
end
