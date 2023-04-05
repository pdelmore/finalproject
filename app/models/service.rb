# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  coverage   :string
#  duration   :string
#  price      :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Service < ApplicationRecord
end
