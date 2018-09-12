class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :collection_id, index: true
      t.string :slug, index: true
      t.string :secret, index: true
      t.string :name
      t.integer :votes, default: 0
      t.integer :views, default: 0
      t.float :score, default: 0

      t.timestamps
    end
  end
end
