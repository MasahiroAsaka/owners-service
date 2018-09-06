class AddColumnToAddresses < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :order, index: true
  end
end
