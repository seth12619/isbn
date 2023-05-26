class AddAttachmentToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :book_cover_id, :bigint
    add_column :books, :book_cover_filename, :string
    add_column :books, :book_cover_content_type, :string
    add_column :books, :book_cover_metadata, :text
  end
end
