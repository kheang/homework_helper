class AddAttachmentScreenToProblems < ActiveRecord::Migration
  def self.up
    change_table :problems do |t|
      t.attachment :screen
    end
  end

  def self.down
    remove_attachment :problems, :screen
  end
end
