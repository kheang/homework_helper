class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :comment
      t.boolean :chosen
      t.references :user, index: true

      t.timestamps
    end
  end
end
