class CreateArts < ActiveRecord::Migration[5.2]
  def change
    create_table :arts do |t|
      t.string :slug
      t.integer :votes
      t.integer :views

      t.timestamps
    end
  end
end
