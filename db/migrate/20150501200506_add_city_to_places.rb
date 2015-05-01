class AddCityToPlaces < ActiveRecord::Migration
  def change
    add_reference :places, :city
  end

end
