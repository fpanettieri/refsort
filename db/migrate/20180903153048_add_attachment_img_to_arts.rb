class AddAttachmentImgToArts < ActiveRecord::Migration[5.2]
  def self.up
    change_table :arts do |t|
      t.attachment :img
    end
  end

  def self.down
    remove_attachment :arts, :img
  end
end
