class Initial < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :access_token
    end


    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.string :excerpt
      t.text :content
      t.integer :author
      t.integer :status
      t.datetime :posted_date
      t.integer :post_category_id
      t.timestamps
    end

    add_column :posts, 'tags',:string, array: true, default: '{}'


    create_table :post_categories do |t|
      t.string :name
    end


  end
end
