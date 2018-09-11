class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.string :name
      t.string :slug, index: true
      t.string :secret, index: true
      t.text :description
      t.boolean :priv, default: false
      t.boolean :approved, default: true

      t.timestamps
    end
  end
end
