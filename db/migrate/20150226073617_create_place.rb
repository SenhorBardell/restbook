class CreatePlace < ActiveRecord::Migration
  def change
    enable_extension :hstore
    create_table :places do |t|
      t.string :logo
      t.string :place_type
      t.string :name
      t.string :img
      t.string :desc
      t.string :city
      t.string :street
      t.string :building
      t.integer :long
      t.integer :lat
      t.json :hours
      t.hstore :flags
    end
  end
end
