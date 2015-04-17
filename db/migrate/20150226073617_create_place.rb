class CreatePlace < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :logo
      t.string :place_type
      t.string :name
      t.string :img
      t.string :desc
      t.string :city
      t.string :street
      t.string :building
      t.string :long
      t.string :lat
      t.json :hours
      t.string :flags, array: true
    end
  end
end
