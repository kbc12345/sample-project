class AddLastUpdatedByToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :last_updated_by, :integer
  end
end
