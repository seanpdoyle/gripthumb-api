class AddAttachmentToVideo < ActiveRecord::Migration
  def change
    add_attachment :videos, :logo
  end
end
