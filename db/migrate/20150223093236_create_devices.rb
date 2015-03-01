class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :token
      t.string :auth
      t.boolean :verified, default: false
      t.belongs_to :user, index: true
    end
  end
end
