# frozen_string_literal: true

module Admin
  class Service < ::Service
    has_many :articles, dependent: :destroy

    has_one_attached :image
    attr_accessor :remove_image

    before_validation { self.image = nil if remove_image.to_s == '1' }

    validates :title, presence: true
    validates :description, presence: true
    validates :price, presence: true
    validates :svc, presence: true
    validates :subtitle, presence: true
    validates :body, presence: true

    enum svc: { repair: 0, sewing: 1 }, _prefix: true

    scope :title_full_like, lambda { |v|
      where(arel_table[:title].matches("%#{v}%")) if v.present?
    }

    scope :svc_any, lambda { |v|
      where(svc: v) if v.present?
    }
  end
end
