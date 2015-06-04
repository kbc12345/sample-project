class AddFeatureInPosts < ActiveRecord::Migration
  def change
    add_column :posts, :featured, :boolean, default: false
    add_column :posts, :order, :integer, default: 0

  end
end
