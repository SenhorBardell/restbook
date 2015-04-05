class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.belongs_to :place
      t.string :area_type, default: 'table'
    end
  end
end
