class CreatePlace < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :logo
      t.string :type
      t.string :name
      t.string :img
      t.string :desc
      t.string :city
      t.string :street
      t.integer :long
      t.integer :lat
      t.boolean :can_book
    end
  end
end
