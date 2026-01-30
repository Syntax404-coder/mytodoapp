# Clear existing data
Reservation.destroy_all
Table.destroy_all
User.destroy_all

# Create admin user
admin = User.create!(
  name: "Admin User",
  email: "admin@kaonta.com",
  password: "password123",
  role: :admin
)

# Create customer user
customer = User.create!(
  name: "Test Customer",
  email: "customer@example.com",
  password: "password123",
  role: :customer
)

# Create time slots for the next 7 days
(1..7).each do |day|
  [12, 18, 20].each do |hour|
    Table.create!(
      start_time: day.days.from_now.change(hour: hour, min: 0),
      capacity: 10,
      remaining_seats: 10
    )
  end
end

puts "Seeded: 1 admin, 1 customer, #{Table.count} time slots"
