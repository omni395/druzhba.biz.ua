# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://druzhba.biz.ua/"
SitemapGenerator::Sitemap.create_index = true

SitemapGenerator::Sitemap.create do
  {uk: :ukrainian, ru: :russian}.each_pair do |locale, name|
    group(sitemaps_path: "sitemaps/#{locale}/", filename: name) do
      add root_path(locale: locale), changefreq: 'daily'
      add prices_path(locale: locale)
      add about_path(locale: locale)
      add contacts_path(locale: locale)
      add faq_path(locale: locale)
      add services_path(locale: locale)
      add articles_path(locale: locale)

      Article.friendly.find_each do |article|
        add article_path(article, locale: locale), changefreq: 'daily', lastmod: article.updated_at
      end
    
      Service.friendly.find_each do |service|
        add service_path(service, locale: locale), changefreq: 'daily', lastmod: service.updated_at
      end 
    end
  end
end
