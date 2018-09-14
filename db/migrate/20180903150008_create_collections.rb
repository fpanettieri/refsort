class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.string :slug, index: true
      t.string :secret, index: true
      t.string :name
      t.text :description
      t.boolean :priv, default: false
      t.boolean :approved, default: false
      t.boolean :nsfw, default: false
      t.boolean :flagged, default: false

      t.timestamps
    end
  end
end
