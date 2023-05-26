require "rails_helper" 

RSpec.describe BooksController, type: :controller do
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

  describe "GET functionalities" do
    it "returns a successful response for index" do
      get :index
      expect(response).to have_http_status(200)
    end

    it "returns a 404 for no book" do
      get :get_json_search, params: {isbn: 1975360230}
      expect(response).to have_http_status(404)
    end

    it "returns a 400 for invalid ISBN" do
      get :get_json_search, params: {isbn: 197521230}
      expect(response).to have_http_status(400)
    end
  end

end