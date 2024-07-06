class Article < ApplicationRecord
  # Frendly urls
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :service
  has_rich_text :body
  has_one_attached :image

  def to_param
    slug
  end

  scope :published, -> {where(published: true)}
end
