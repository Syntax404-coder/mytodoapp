module Admin
  class ReservationsController < ApplicationController
    before_action :require_admin

    def index
      @reservations = Reservation.includes(:user, :table).order(created_at: :desc)
    end
  end
end
