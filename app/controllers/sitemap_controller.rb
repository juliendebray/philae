class SitemapController < ApplicationController
  respond_to :xml

  def index
    @experiences = Experience.order("created_at DESC")
    @providers = Provider.order("created_at DESC")
  end
end
