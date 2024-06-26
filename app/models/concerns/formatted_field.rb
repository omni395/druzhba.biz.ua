module FormattedField
  extend ActiveSupport::Concern

  def created_at_field
    attributes['created_at'].strftime("%d-%m-%Y %H:%M")
  end

  def updated_at_field
    attributes['updated_at'].strftime("%d-%m-%Y %H:%M")
  end

end