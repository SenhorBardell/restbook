class AddTokenToAdminDevices < ActiveRecord::Migration
  def change
    add_column :admin_devices, :token, :string
  end
end
