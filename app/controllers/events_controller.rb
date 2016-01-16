class EventsController < ApplicationController
  def index
  	@date = params[:date] ? Date.parse(params[:date]) : Date.today
  	if Event.published_now.where(date: @date.beginning_of_day..@date.end_of_day).present?
  		@day_events = Event.published_now.where(date: @date.beginning_of_day..@date.end_of_day).order(:date)
  		@events = Event.published_now.where("date >= ?", @date.tomorrow).order(:date)
  	else
  		@events = Event.published_now.where("date >= ?", @date.beginning_of_month).order(:date)
  	end
  	@events_by_date = @future_events.group_by {|t| t.date.to_formatted_s(:numerals)}
  end

  def show
  	@event = Event.friendly.find(params[:id])
  end
end
