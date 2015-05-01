class RemoveCityFromPlaces < ActiveRecord::Migration
  def change
    remove_column :places, :city
  end
end
