desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment }) do
  require "faker"

  # Define an array of sample messages
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

  # Create 50 new Notes
  75.times do
    # Generate random data for the Note
    body = sample_messages.sample(rand(5..8)).join("\n")
    date = Faker::Date.between(from: "2023-04-01", to: "2023-04-30")
    time = Faker::Time.between(from: date.to_time + 10.hours, to: date.to_time + 19.hours)
    patient_id = rand(1..11)
    service_id = rand(1..7)
    user_id = rand(1..5)

    # Create a new Note with the generated data
    Note.create(body: body, date: date, time: time, patient_id: patient_id, service_id: service_id, user_id: user_id)
  end
end
