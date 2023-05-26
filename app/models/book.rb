class Book < ApplicationRecord
  has_one_attached :book_cover
  has_and_belongs_to_many :authors
  belongs_to :publisher, :foreign_key => "publisher_id"

  validates :authors, :presence => true

  def book_author_list
    result = ""
    self.authors.each_with_index do |author, index|
      if !author.middle_name.blank?
        author_mid_name = "#{author.middle_name.to_s} "
      else
        author_mid_name = ""
      end
      author_name = "#{author.first_name.to_s} " + author_mid_name + "#{author.last_name.to_s}"
      result += author_name if index == 0
      result += ", #{author_name}" if index != 0
    end
    return result
  end

  def book_cover_url
    if book_cover.attached?
      book_cover
    else
      ActionController::Base.helpers.asset_path('not-found.png')
    end
  end
end
