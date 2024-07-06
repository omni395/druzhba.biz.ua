class Service < ApplicationRecord
  # Frendly urls
  extend FriendlyId
  friendly_id :title, use: :slugged

  has_many :order_details
  has_many :articles
  has_one_attached :image
  has_rich_text :body

  def to_param
    slug
  end
end
