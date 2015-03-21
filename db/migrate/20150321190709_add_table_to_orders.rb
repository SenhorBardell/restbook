class AddTableToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :table, :string
  end
end
