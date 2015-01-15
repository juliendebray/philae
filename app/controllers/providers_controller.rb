class ProvidersController < ApplicationController
  def index
    @providers = Provider.all
  end

  def show
  end
end
