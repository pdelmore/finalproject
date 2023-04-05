# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  body       :text
#  date       :date
#  time       :time
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  patient_id :integer
#  service_id :integer
#  user_id    :integer
#
class Note < ApplicationRecord
end
