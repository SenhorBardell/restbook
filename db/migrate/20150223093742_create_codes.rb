class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string :code
      t.string :token
      t.timestamp :created_at
      t.belongs_to :device, index: true
    end
  end
end
