class CreateReleases < ActiveRecord::Migration[5.0]
  def change
    create_table :releases do |t|
      t.references :song, foreign_key: true, null: false
      t.references :artist, foreign_key: true, null: false

      t.timestamps
    end
  end
end
