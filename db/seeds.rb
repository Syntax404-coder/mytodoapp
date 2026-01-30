# Idempotent seed script
# Generates operating hours: 07:00 - 22:00 PHT with 30-minute intervals

# Create default users if they don't exist
if User.count == 0
  User.create!(
    name: "Admin User",
    email: "admin@kaonta.com",
    password: "password123",
    role: :admin
  )

  User.create!(
    name: "Test Customer",
    email: "customer@example.com",
    password: "password123",
    role: :customer
  )

  puts "Seeded: Default users created"
end

# Clear existing slots to prevent duplicates or clashes during re-seed
Table.destroy_all

# Set timezone context
manila_zone = ActiveSupport::TimeZone["Asia/Manila"]

# Generate slots for the next 7 days
(0..6).each do |day_offset|
  current_date = manila_zone.now.to_date + day_offset.days

  # Operating hours: 07:00 to 22:00 (10 PM)
  # 30-minute intervals means two slots per hour
  (7..21).each do |hour|
    [0, 30].each do |minute|
      # Stop if we exceed 22:00 (though loop ends at 21, so 21:30 is last slot, which is correct for closing at 22:00)
      start_time = manila_zone.local(current_date.year, current_date.month, current_date.day, hour, minute, 0)
      
      Table.create!(
        start_time: start_time,
        capacity: 10,
        remaining_seats: 10
      )
    end
  end
end

puts "Seeded: Time slots generated for 7 days (07:00 - 22:00 PHT)"
