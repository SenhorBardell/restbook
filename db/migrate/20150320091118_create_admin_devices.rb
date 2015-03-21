class CreateAdminDevices < ActiveRecord::Migration
  def change
    create_table :admin_devices do |t|
      t.string :udid
      t.string :auth
      t.belongs_to :place, index: true
    end
  end
end
