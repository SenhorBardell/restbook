class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.string :price
      t.integer :message_id
      t.string :number, limit: 11
      t.string :status
    end
  end
end
