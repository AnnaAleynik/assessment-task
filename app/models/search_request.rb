class SearchRequest < ApplicationRecord
  validates :keyword, presence: true

  validates :total_pages, :page, :count, numericality: { greater_than_or_equal_to: 0 }
end
