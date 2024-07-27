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
    validates :service_body, presence: true

    enum svc: { repair: 0, sewing: 1 }, _prefix: true


    scope :title_full_like, ->(v) do
      where(arel_table[:title].matches("%#{v}%")) if v.present?
    end

    scope :svc_any, ->(v) do
      where(svc: v) if v.present?
    end


  end
end
