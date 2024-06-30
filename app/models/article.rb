class Article < ApplicationRecord
  belongs_to :service
  has_rich_text :body
end
