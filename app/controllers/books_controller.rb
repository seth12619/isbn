require 'lisbn'

class BooksController < ApplicationController
  def index
  end

  def search
    isbn = Lisbn.new("#{params[:isbn]}")
    if !is_isbn(isbn)
      puts "no: #{isbn}"
      @search_result = "invalid_isbn"
    else
      puts "yes: #{isbn}"
      @search_result = "valid_isbn"
      isbn_13_build = Lisbn.new(isbn.isbn13).parts.join("-")
      @book = Book.where(isbn_13: "#{isbn_13_build}").first
    end
    render :index
  end

  def get_json_search
    isbn = Lisbn.new("#{params[:isbn]}")
    if !is_isbn(isbn)
      puts "no: #{isbn}"
      @search_result = "invalid_isbn"
      head :bad_request
      return
    else
      puts "yes: #{isbn}"
      @search_result = "valid_isbn"
      isbn_13_build = Lisbn.new(isbn.isbn13).parts.join("-")
      @book = Book.where(isbn_13: "#{isbn_13_build}").first
    end

    if @book.blank?
      head :not_found
      return
    end

    json_builder = {
      title: @book.title,
      author: @book.book_author_list,
      isbn_13: @book.isbn_13,
      isbn_10: @book.isbn_10,
      publication_year: @book.year,
      publisher: @book.publisher.name,
      edition: @book.edition,
      price: @book.list_price
    }

    render json: json_builder
  end

  def isbn_transformer
    isbn = Lisbn.new("#{params[:isbn]}")
    if !is_isbn(isbn)
      puts "no: #{isbn}"
      render json: {transformed_isbn: "Invalid ISBN"}
      return
    else
      isbn_type = check_isbn("#{params[:isbn]}")
    end
    if isbn_type == "isbn_10"
      isbn_13_build = Lisbn.new(isbn.isbn13).parts.join("-")
      @transformed_isbn = isbn_13_build
    else
      isbn_10_build = add_hypens_isbn_10(isbn.isbn10)
      @transformed_isbn = isbn_10_build
    end

    render json: {transformed_isbn: @transformed_isbn}
  end

  private

  def is_isbn(isbn)
    check_isbn = Lisbn.new(isbn)
    return check_isbn.valid?
  end

  def check_isbn(isbn)
    # Remove any hyphens or spaces from the ISBN
    isbn = isbn.gsub(/[-\s]/, '')

    if isbn.length == 10
      return "isbn_10"
    elsif isbn.length == 13
      return "isbn_13"
    end
  end

  def add_hypens_isbn_10(isbn)
    # clean isbn
    isbn = isbn.gsub(/[-\s]/, '')

    isbn_builder = isbn.insert(1, '-')
    isbn_builder.insert(5, '-')
    isbn_builder.insert(11, '-')

    return isbn_builder
  end

end