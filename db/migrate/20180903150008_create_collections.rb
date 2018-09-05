class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.string :name
      t.string :slug
      t.string :secret
      t.text :description
      t.boolean :private

      t.timestamps
    end
  end
end
