# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "faker"

Note.destroy_all
Patient.destroy_all
User.destroy_all
Service.destroy_all

User.create!(
  first_name: "Alice",
  last_name: "Smith",
  email: "alice@example.com",
  admin: true,
  password: "password",
)

9.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "#{first_name.downcase}@example.com"
  admin = false

  user = User.new(
    first_name: first_name,
    last_name: last_name,
    email: email,
    admin: admin,
    password: "password",
  )
  user.save(validate: false)
end

Service.create!(
  coverage: "cash",
  duration: "30",
  price: "35",
  title: "massage",
  id: 1000,
)
Service.create!(
  coverage: "cash",
  duration: "45",
  price: "51",
  title: "massage",
  id: 1001,
)
Service.create!(
  coverage: "cash",
  duration: "60",
  price: "70",
  title: "massage",
  id: 1002,
)

50.times do |i|
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  dob = Faker::Date.birthday(min_age: 18, max_age: 90)
  phone_number = Faker::PhoneNumber.cell_phone_in_e164
  gender = Faker::Gender.binary_type
  address = Faker::Address.full_address
  general_notes = Faker::Lorem.sentence

  Patient.create!(
    first_name: first_name,
    last_name: last_name,
    dob: dob,
    phone_number: phone_number,
    gender: gender,
    address: address,
    general_notes: general_notes,
  )
end


sample_messages = [
  "Patient reports feeling more relaxed after the massage.",
  "Noted an increase in range of motion in the patient's left shoulder.",
  "Patient reports feeling some discomfort in the lower back during the massage.",
  "Noted some tightness in the patient's neck and shoulders.",
  "Patient reports feeling refreshed and rejuvenated after the massage.",
  "Noted some inflammation in the patient's right elbow.",
  "Patient reports feeling sleepy during the massage and falling asleep for a few minutes.",
  "Noted some areas of tenderness in the patient's lower legs.",
  "Patient reports feeling a significant reduction in pain after the massage.",
  "Noted some stiffness in the patient's upper back and shoulders.",
  "Patient reports feeling more energized after the massage.",
  "Noted some swelling in the patient's left ankle.",
  "Patient reports feeling very relaxed during the massage and almost falling asleep.",
  "Noted some muscle knots in the patient's upper back and shoulders.",
  "Patient reports feeling some soreness in the glutes after the massage.",
  "Noted some tension in the patient's jaw and neck muscles.",
  "Patient reports feeling more flexible after the massage.",
  "Noted some tingling sensations in the patient's fingers and toes.",
  "Patient reports feeling a warm and pleasant sensation throughout the body during the massage.",
  "Noted some muscle imbalances in the patient's legs.",
  "Patient reports feeling a slight headache after the massage.",
  "Noted some clicking sounds in the patient's right knee during range of motion exercises.",
  "Patient reports feeling a sense of calm and relaxation after the massage.",
  "Noted some areas of congestion in the patient's chest and sinuses.",
  "Patient reports feeling some discomfort in the hips during the massage.",
  "Noted some areas of dryness and flakiness on the patient's skin.",
  "Patient reports feeling more centered and balanced after the massage.",
  "Noted some tenderness in the patient's neck and upper back muscles.",
  "Patient reports feeling a sense of relief after the massage.",
  "Noted some minor bruising on the patient's arms and legs.",
  "Patient reports feeling a deep sense of relaxation during the massage.",
  "Noted some areas of tightness in the patient's hips and glutes.",
  "Patient reports feeling more connected to the body after the massage.",
  "Noted some redness and irritation on the patient's skin.",
  "Patient reports feeling more grounded and present after the massage.",
  "Noted some areas of inflammation in the patient's hands and feet.",
  "Patient reports feeling a sense of clarity and focus after the massage.",
  "Noted some muscle weakness in the patient's right arm.",
  "Patient reports feeling some discomfort in the stomach area during the massage.",
  "Noted some areas of sensitivity on the patient's skin.",
  "Patient reports feeling a sense of release and letting go after the massage.",
  "Noted some tension and tightness in the patient's jaw muscles.",
  "Patient reports feeling more open and receptive after the massage.",
  "Noted some areas of bruising on the patient's back and shoulders.",
  "Patient reports feeling more in touch with the emotions after the massage.",
  "Noted some swelling and tenderness in the patient's feet and ankles.",
  "Patient reports feeling a sense of joy and happiness after the massage.",
  "Noted some areas of restriction in the patient's hip and knee joints.",
]

start_date = Date.parse("April 1, 2021")
end_date = Date.parse("May 30, 2023")
start_time = Time.parse("8:00am")
end_time = Time.parse("6:00pm")


300.times do
  Note.create(
    body: sample_messages.sample(rand(3..8)).join("\n"),
    date: rand(start_date..end_date),
    time: rand(start_time..end_time),
    patient_id: rand(1..50),
    user_id: rand(1..10), 
    service_id: rand(1..3) 
  )
end

puts "Generated sample data"
