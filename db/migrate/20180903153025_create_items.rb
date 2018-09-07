class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :collection_id, index: true
      t.string :slug
      t.string :secret
      t.integer :votes
      t.integer :views
      t.boolean :fresh, default: true

      t.timestamps
    end
  end
end
