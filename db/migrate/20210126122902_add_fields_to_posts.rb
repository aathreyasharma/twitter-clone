class AddFieldsToPosts < ActiveRecord::Migration[6.1]
  def up
    add_column :posts, :body, :string, default: nil
    add_column :posts, :type, :string
    add_column :posts, :status, :string, default: 'draft'
    add_column :posts, :parent_id, :integer, default: nil
    add_column :posts, :deleted_at, :datetime, default: nil
    add_reference :posts, :user, foreign_key: true
  end

  def down
    remove_column :posts, :body
    remove_column :posts, :type
    remove_column :posts, :status
    remove_column :posts, :parent_id
    remove_column :posts, :deleted_at
    remove_column :posts, :user_id
  end
end
