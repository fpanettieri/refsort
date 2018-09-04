class AddAttachmentImgToRefs < ActiveRecord::Migration[5.2]
  def self.up
    change_table :refs do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :refs, :img
  end
end
