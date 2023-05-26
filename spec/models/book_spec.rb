require 'rails_helper'

RSpec.describe Book, type: :model do
  context "We have a book object" do
    let!(:book) do
      author = Author.create(first_name: "Rainer", middle_name: "Steel", last_name: "Rilke")
      publisher = Publisher.create(name: "McSweeney's")
      book = Book.create(title: "The Underwater Welder", isbn_10: "1-603-09398-2", isbn_13: "978-1-60309-398-9", list_price: 3000, year: 2022, edition: "", publisher_id: publisher.id)
      book.authors << author
      file_path = Rails.root.join('public', 'storage', 'The Underwater Welder.png')
      book.book_cover.attach(io: File.open(file_path), filename: 'The Underwater Welder.png')
      book.save

      book
    end

    it 'will return authors list' do
      expect(book.book_author_list).to eq("Rainer Steel Rilke")
    end

    it 'will return a book cover' do
      expect(book.book_cover_url).to be_truthy
    end
  end
end
