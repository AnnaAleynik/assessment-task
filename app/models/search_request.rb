class SearchRequest < ApplicationRecord
  validates :keyword, presence: true
end
