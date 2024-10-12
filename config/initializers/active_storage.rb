Rails.application.config.to_prepare do
  ActiveStorage::Blob.class_eval do
    def service_headers(filename:, disposition:, content_type:, **)
      super.merge('X-Robots-Tag' => 'noindex')
    end
  end
end