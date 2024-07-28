class Service < ApplicationRecord
  extend Mobility
  translates :title, type: :string
  translates :subtitle, type: :string
  translates :description, type: :string
  translates :body, backend: :action_text
  translates :slug, :title

  # Frendly urls
  extend FriendlyId
  friendly_id :title, use: :mobility

  has_many :order_details
  has_many :articles
  has_one_attached :image
  #has_rich_text :body

  def to_param
    slug
  end

  scope :repair, -> { where(svc: 0) } 
  scope :sewing, -> { where(svc: 1) }
end
