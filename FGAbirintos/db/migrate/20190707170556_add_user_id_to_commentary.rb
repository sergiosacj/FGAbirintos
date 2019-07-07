class AddUserIdToCommentary < ActiveRecord::Migration[5.2]
  def change
    add_reference :commentaries, :user, foreign_key: true
  end
end
