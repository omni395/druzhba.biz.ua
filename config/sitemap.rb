# frozen_string_literal: true

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://druzhba.biz.ua/'
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  { uk: :ukrainian, ru: :russian }.each_pair do |locale, name|
    group(sitemaps_path: "sitemaps/#{locale}/", filename: name) do
      I18n.locale = locale
      add root_path(locale:), changefreq: 'daily'
      add prices_path(locale:)
      #add about_path(locale:)
      add contacts_path(locale:)
      add faq_path(locale:)
      add services_path(locale:)
      add articles_path(locale:)

      Article.friendly.find_each do |article|
        add article_path(article, locale:), changefreq: 'daily', lastmod: article.updated_at
      end

      Service.friendly.find_each do |service|
        add service_path(service.slug, locale:), changefreq: 'daily', lastmod: service.updated_at
      end
    end
  end
end

# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'https://www.druzhba.biz.ua/'
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  { uk: :ukrainian, ru: :russian }.each_pair do |locale, name|
    group(sitemaps_path: "sitemaps/#{locale}/", filename: name) do
      I18n.locale = locale
      add root_path(locale:), changefreq: 'daily'
      add prices_path(locale:)
      #add about_path(locale:)
      add contacts_path(locale:)
      add faq_path(locale:)
      add services_path(locale:)
      add articles_path(locale:)

      Article.friendly.find_each do |article|
        add article_path(article, locale:), changefreq: 'daily', lastmod: article.updated_at
      end

      Service.friendly.find_each do |service|
        add service_path(service.slug, locale:), changefreq: 'daily', lastmod: service.updated_at
      end
    end
  end
end

#SitemapGenerator::Sitemap.default_host = 'https://druzhba.biz.ua/'
#SitemapGenerator::Sitemap.create_index = true
#SitemapGenerator::Sitemap.compress = true
#
#SitemapGenerator::Sitemap.create do
#  { uk: :ukrainian, ru: :russian }.each_pair do |locale, name|
#    group(sitemaps_path: "sitemaps/#{locale}/", filename: name) do
#      I18n.locale = locale
#      add root_path(locale:), changefreq: 'daily'
#      add prices_path(locale:)
#      add about_path(locale:)
#      add contacts_path(locale:)
#      add faq_path(locale:)
#      add services_path(locale:)
#      add articles_path(locale:)
#
#      Article.friendly.find_each do |article|
#        add article_path(article, locale:), changefreq: 'daily', lastmod: article.updated_at
#      end
#
#      Service.friendly.find_each do |service|
#        add service_path(service.slug, locale:), changefreq: 'daily', lastmod: service.updated_at
#      end
#    end
#  end
#end
