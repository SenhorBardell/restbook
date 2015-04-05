class ChangeOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.remove :table
      t.belongs_to :area, index: true
    end
  end
end
