class ReservationsController < ApplicationController
  before_action :require_login

  def create
    @table = Table.find(params[:table_id])
    @reservation = current_user.reservations.build(
      table: @table,
      guest_count: params[:guest_count].to_i
    )

    if @reservation.save
      redirect_to tables_path, notice: "Reservation confirmed!"
    else
      redirect_to tables_path, alert: @reservation.errors.full_messages.join(", ")
    end
  end

  def index
    @reservations = current_user.reservations.includes(:table).order(created_at: :desc)
  end
end
