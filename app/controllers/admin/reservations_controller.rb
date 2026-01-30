module Admin
  class ReservationsController < ApplicationController
    before_action :require_admin

    def index
      @reservations = Reservation.includes(:user, :table).order(created_at: :desc)
    end

    def destroy
      @reservation = Reservation.find(params[:id])

      # Send cancellation email to user
      ReservationMailer.with(reservation: @reservation).cancellation_email.deliver_now

      @reservation.destroy
      redirect_to admin_dashboard_path, notice: "Reservation cancelled and notification sent to user."
    end
  end
end
