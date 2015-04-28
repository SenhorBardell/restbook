class ChangeVoteToReviews < ActiveRecord::Migration
  def up
    change_column :reviews, :vote, :integer, limit: 1, default: 2, null: false
  end

  def down
    change_column :reviews, :vote, :integer, limit: 1, default: 2, null: true
  end
end
