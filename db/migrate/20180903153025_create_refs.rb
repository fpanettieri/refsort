class CreateRefs < ActiveRecord::Migration[5.2]
  def change
    create_table :refs do |t|
      t.string :slug
      t.string :secret
      t.integer :votes
      t.integer :views

      t.timestamps
    end
  end
end
