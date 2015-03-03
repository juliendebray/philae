# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.explorizers.com"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.

  routes = Rails.application.routes.routes.map do |route|
      {alias: route.name, path: route.path.spec.to_s, controller: route.defaults[:controller], action: route.defaults[:action]}
    end

    # Set a list of controllers you don't want to generate routes for.
    # /rails/info in particular maps to something inaccessible.
    # redirects have a nil controller. This prevents duplicate content penalties.
    banned_controllers = ["rails/info", nil, "active_admin"]
    routes.reject! {|route| banned_controllers.include?(route[:controller])}
    puts routes
    # sitemap_generator includes root by default; prevent duplication
    routes.reject! {|route| route[:path] == '/'}

    routes.each {|route| add route[:path][0..-11]} # Strips off '(.:format)

    # Notice the below if you're hosting Jekyll/Octopress in a subdirectory
    # or otherwise want to index content outside of Rails' routes.
    # add_to_index '/path/sitemap.xml'

    # Source = http://hackingoff.com/blog/generate-rails-sitemap-from-routes/
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
