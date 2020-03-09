class AddInReplyToColumnToMicroposts < ActiveRecord::Migration[5.2]
  def change
    add_reference :microposts, :in_reply_to, foreign_key: { to_table: :users}
    add_index :microposts, [:in_reply_to_in, :created_at]
  end
end
