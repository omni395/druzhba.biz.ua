# frozen_string_literal: true

class Article < ApplicationRecord
  extend Mobility
  translates :title
  translates :description
  translates :body, backend: :action_text
  translates :slug, :title

  # Frendly urls
  extend FriendlyId
  friendly_id :title, use: :mobility

  belongs_to :service, optional: true
  # has_rich_text :body
  has_one_attached :image

  def to_param
    slug
  end

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end

  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }

  def created_at_field
    attributes['created_at'].strftime('%d-%m-%Y %H:%M')
  end

  def updated_at_field
    attributes['updated_at'].strftime('%d-%m-%Y %H:%M')
  end
end
