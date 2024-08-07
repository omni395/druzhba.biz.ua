class Article < ApplicationRecord
  extend Mobility
  translates :title
  translates :description
  translates :body, backend: :action_text
  translates :slug, :title

  # Frendly urls
  extend FriendlyId
  friendly_id :title, use: :mobility

  belongs_to :service
  #has_rich_text :body
  has_one_attached :image

  def to_param
    slug
  end

  def should_generate_new_friendly_id?
    slug.blank? || self.title_changed?
  end

  scope :published, -> {where(published: true)}
end
