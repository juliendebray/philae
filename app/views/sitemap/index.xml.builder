xml.instruct!

xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  xml.url do
    xml.loc root_url
    xml.changefreq("hourly")
    xml.priority "1.0"
  end
  @experiences.each do |experience|
    xml.url do
      xml.loc experience_url(experience)
      xml.changefreq("daily")
      xml.priority "0.8"
      xml.lastmod experience.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
    end
  end
  @providers.each do |provider|
    xml.url do
      xml.loc provider_url(provider)
      xml.changefreq("daily")
      xml.priority "0.8"
      xml.lastmod provider.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
    end
  end


xml.target! << '<url>
  <loc>http://www.explorizers.com/</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/users/sign_up</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/users/sign_in</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/story</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/contacts/new</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/destinations</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/providers</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/en</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/fr</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/users/sign_up?locale=en</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/users/sign_up?locale=fr</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/users/sign_in?locale=en</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/users/sign_in?locale=fr</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/users/password/new</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/en/story</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/fr/story</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/en/contacts/new</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/fr/contacts/new</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/en/destinations</loc>
  <changefreq>daily</changefreq>
</url>
<url>
  <loc>http://www.explorizers.com/fr/destinations</loc>
  <changefreq>daily</changefreq>
</url>
'


end
