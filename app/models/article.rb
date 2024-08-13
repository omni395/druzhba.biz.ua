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

  def created_at_display
    created_at ? I18n.l(created_at) : ''
  end

  def updated_at_display
    updated_at ? I18n.l(updated_at) : ''
  end

  def created_at_field
    attributes['created_at'].strftime("%d-%m-%Y %H:%M")
  end

  def updated_at_field
    attributes['updated_at'].strftime("%d-%m-%Y %H:%M")
  end
end
