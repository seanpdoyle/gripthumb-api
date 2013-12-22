class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :name, null: false
      t.belongs_to :song, index: true
      t.belongs_to :video, index: true

      t.timestamps
    end
  end
end
