module Admin
  class Service < ::Service
    has_many :articles, dependent: :destroy

    has_one_attached :image
    attr_accessor :remove_image
    before_validation { self.image = nil if remove_image.to_s == '1' }


    scope :title_full_like, ->(v) do
      where(arel_table[:title].matches("%#{v}%")) if v.present?
    end


  end
end
