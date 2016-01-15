class EventsController < ApplicationController
  def index
  	@events = Event.future.order(:date)
  	@events_by_date = @events.group_by(&:date)
  	@date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def show
  	@event = Event.friendly.find(params[:id])
  end
end
