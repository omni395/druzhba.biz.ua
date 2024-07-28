class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # After active storage urls are changed, use this to recreate all trix attachments
  def self.refresh_trixes
    ActionText::RichText.where.not(body: nil).find_each do |trix|
      refresh_trix(trix)
    end
  end

  # After active storage urls are changed, use this to recreate a specific trix attachments
  def self.refresh_trix(trix)
    return unless trix.embeds.size.positive?

    trix.body.fragment.find_all("action-text-attachment").each do |node|
      embed = trix.embeds.find { |attachment| attachment.filename.to_s == node["filename"] && attachment.byte_size.to_s == node["filesize"] }

      node.attributes["url"].value = Rails.application.routes.url_helpers.rails_storage_redirect_url(embed.blob, host: "druzhba.biz.ua")
      node.attributes["sgid"].value = embed.attachable_sgid
    end

    trix.update_column :body, trix.body.to_s
  end
end
