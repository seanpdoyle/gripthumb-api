class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name, null: false
      t.string :guid, null: false
      t.string :artist_name, null: false

      t.index :guid, unique: true

      t.timestamps
    end
  end
end
