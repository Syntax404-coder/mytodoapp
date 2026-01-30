class TablesController < ApplicationController
  before_action :require_login

  def index
    # Redirect admin to dashboard
    if current_user.admin?
      redirect_to admin_dashboard_path
      return
    end

    # Get selected date or default to today
    @today_date = Date.current
    @selected_date = params[:date].present? ? Date.parse(params[:date]) : @today_date

    # Get ALL tables for the selected date - simple date comparison
    @tables = Table.where(
      "DATE(start_time) = ?", @selected_date.to_s
    ).order(:start_time)
  end
end
