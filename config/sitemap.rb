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

      Article.find_each do |article|
        add articles_path(article, locale: locale), changefreq: 'daily', lastmod: article.updated_at
      end
    
      Service.find_each do |service|
        add services_path(service, locale: locale), changefreq: 'daily', lastmod: service.updated_at
      end 
    end
  end
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
