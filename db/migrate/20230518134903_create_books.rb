class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string "title"
      t.string "isbn_10"
      t.string "isbn_13"
      t.float "list_price"
      t.integer "year"
      t.string "edition"

      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
