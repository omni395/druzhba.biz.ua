# frozen_string_literal: true

module Admin
  class RichTextAreaComponent < ViewComponent::Base
    def initialize(form, field, form_kind: nil, html_class: nil)
      @form = form
      @field = field
    end

    def rich_text_area
      @form.send(@form, @field)
    end
  end
end