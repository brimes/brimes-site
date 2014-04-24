class SiteController < ApplicationController
  layout "site"
  def index
    @time = Time.new
  end
end
