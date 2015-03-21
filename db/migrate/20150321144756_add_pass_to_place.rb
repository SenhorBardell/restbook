class AddPassToPlace < ActiveRecord::Migration
  def change
    add_column :places, :pass, :string
  end
end
