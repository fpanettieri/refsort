class AddAttachmentImgToCollections < ActiveRecord::Migration[5.2]
  def self.up
    change_table :collections do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :collections, :img
  end
end
