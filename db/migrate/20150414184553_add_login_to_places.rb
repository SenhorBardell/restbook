class AddLoginToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :login, :string
  end
end
