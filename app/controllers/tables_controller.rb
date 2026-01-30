class TablesController < ApplicationController
  before_action :require_login

  def index
    # Redirect admin to dashboard
    if current_user.admin?
      redirect_to admin_dashboard_path
      return
    end

    @today_date = Date.current
    @selected_date = params[:date].present? ? Date.parse(params[:date]) : @today_date

    # Use timezone-aware range query
    day_start = @selected_date.beginning_of_day
    day_end = @selected_date.end_of_day

    @tables = Table.where(start_time: day_start..day_end).order(:start_time)
  end
end
