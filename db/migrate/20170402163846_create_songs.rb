class CreateSongs < ActiveRecord::Migration[5.0]
  def change
    create_table :songs do |t|
      t.string :song_title, null: false
      t.references :album, foreign_key: true, null: false
      t.timestamps
    end
  end
end
