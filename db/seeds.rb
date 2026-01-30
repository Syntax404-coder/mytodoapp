# Only seed if tables are empty (idempotent for production)
if User.count == 0
  # Create admin user
  User.create!(
    name: "Admin User",
    email: "admin@kaonta.com",
    password: "password123",
    role: :admin
  )

  # Create customer user
  User.create!(
    name: "Test Customer",
    email: "customer@example.com",
    password: "password123",
    role: :customer
  )

  puts "Seeded: 2 users"
end

if Table.count == 0
  # Create time slots for the next 7 days
  manila_zone = ActiveSupport::TimeZone["Asia/Manila"]
  
  (0..6).each do |day_offset|
    # Get the date for the current iteration in Manila time
    current_date = manila_zone.now.to_date + day_offset.days
    
    # Create slots from 7 AM to 9 PM (21:00)
    (7..21).each do |hour|
      start_time = manila_zone.local(current_date.year, current_date.month, current_date.day, hour, 0, 0)
      
      Table.create!(
        start_time: start_time,
        capacity: 10,
        remaining_seats: 10
      )
    end
  end

  puts "Seeded: #{Table.count} time slots"
end
