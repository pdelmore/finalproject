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
  belongs_to :patient, { :required => true, :class_name => "Patient", :foreign_key => "patient_id" }
  belongs_to :service, { :required => true, :class_name => "Service", :foreign_key => "service_id" }
  belongs_to :user, { :required => true, :class_name => "User", :foreign_key => "user_id" }

  validates(:body, { :presence => true })
  validates(:date, { :presence => true })
  validates(:time, { :presence => true })
  validates(:patient_id, { :presence => true })
  validates(:service_id, { :presence => true })
  validates(:user_id, { :presence => true })

  def start_time
    self.date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
  end
end
