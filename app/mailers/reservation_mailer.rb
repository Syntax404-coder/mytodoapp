class ReservationMailer < ApplicationMailer
  default from: "notifications@kaonta.com"

  def cancellation_email
    @reservation = params[:reservation]
    @user = @reservation.user
    @table = @reservation.table

    mail(to: @user.email, subject: "Reservation Cancellation Notice")
  end
end
