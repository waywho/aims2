class NewsItemsController < ApplicationController
  def index
  	@newsies = NewsItem.published_now.order(published_at: :desc)
  end

  def show
  	@news = NewsItem.friendly.find(params[:id])
  	@newsies = NewsItem.published_now.order(published_at: :desc)
  end
end
