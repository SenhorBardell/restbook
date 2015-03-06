class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :user, index: true
      t.belongs_to :place, index: true
      t.datetime :datetime
      t.string :info
      t.string :guests
      t.string :status, default: 'pending'
      t.timestamps null: false
    end
  end
end
