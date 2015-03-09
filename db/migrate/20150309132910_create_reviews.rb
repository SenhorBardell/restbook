class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :user, index: true
      t.belongs_to :place, index: true
      t.text :text
      t.integer :vote, default: nil, limit: 1
      t.timestamp :created_at
    end
  end
end
