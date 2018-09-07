class AddAttachmentImgToItems < ActiveRecord::Migration[5.2]
  def self.up
    change_table :items do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :items, :img
  end
end
