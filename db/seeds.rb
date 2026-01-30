# Kaon Ta! Seed Data
# Simple schedule: Breakfast, Lunch, Dinner slots

# Create users if none exist
if User.count == 0
  User.create!(name: "Admin User", email: "admin@kaonta.com", password: "password123", role: :admin)
  User.create!(name: "Test Customer", email: "customer@kaonta.com", password: "password123", role: :customer)
  puts "Created default users"
end

# Clear all tables (Ensures clean slate for the correct 12-slot schedule)
puts "Resetting tables..."
Table.destroy_all

# Simple hours array (Manila Time, 24-hour format)
BREAKFAST_HOURS = [ 7, 8, 9, 10 ]
LUNCH_HOURS = [ 11, 12, 13, 14 ]
DINNER_HOURS = [ 18, 19, 20, 21 ]
ALL_HOURS = BREAKFAST_HOURS + LUNCH_HOURS + DINNER_HOURS

# Create slots for next 8 days
8.times do |day_offset|
  date = Date.current + day_offset.days

  ALL_HOURS.each do |hour|
    # Store as simple datetime - no timezone conversion needed
    slot_time = Time.zone.local(date.year, date.month, date.day, hour, 0, 0)

    Table.create!(
      start_time: slot_time,
      capacity: 10,
      remaining_seats: 10
    )
  end
end

puts "Created #{Table.count} time slots (#{ALL_HOURS.length} hours x 8 days)"
