module Admin
  class Service < ::Service
    has_one_attached :photo
    attr_accessor :remove_photo
    before_validation { self.photo = nil if remove_photo.to_s == '1' }


    scope :title_full_like, ->(v) do
      where(arel_table[:title].matches("%#{v}%")) if v.present?
    end


  end
end
