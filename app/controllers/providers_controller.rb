class ProvidersController < ApplicationController
  before_action :set_provider, only: [:show]

  def index
    @providers = Provider.all
  end

  def show
  end

  private
  def set_provider
    @provider = Provider.find(params[:id])
  end
end
