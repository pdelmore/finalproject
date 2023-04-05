# == Schema Information
#
# Table name: patients
#
#  id            :integer          not null, primary key
#  address       :string
#  first_name    :string
#  general_notes :text
#  last_name     :string
#  phone_number  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Patient < ApplicationRecord
end
