class NewsItemsController < ApplicationController
  def index
  	@newsies = NewsItem.published_now.order(:published_at)
  end

  def show
  	@news = NewsItem.friendly.find(params[:id])
  end
end
