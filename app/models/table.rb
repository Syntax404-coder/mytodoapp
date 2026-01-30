class Table < ApplicationRecord
  has_many :reservations, dependent: :destroy

  validates :start_time, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :remaining_seats, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def available?
    remaining_seats > 0
  end
end
