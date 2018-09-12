class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :collection_id, index: true
      t.string :name
      t.string :slug, index: true
      t.string :secret, index: true
      t.integer :votes
      t.integer :views
      t.float :score

      t.timestamps
    end
  end
end
