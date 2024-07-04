module Admin
  class Article < ::Article
    has_one_attached :image
    attr_accessor :remove_image
    before_validation { self.image = nil if remove_image.to_s == '1' }


    scope :id_eq, ->(v) do
      where(id: v) if v.present?
    end


  end
end
