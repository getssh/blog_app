class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo, default: "https://unsplash.com/photos/F_-0BxGuVvo"
      t.text :bio
      t.integer :post_counter, default: 0
      t.timestamps
    end
    add_index :users, :name
  end
end
