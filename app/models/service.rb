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

  validates :coverage, :presence => true
  validates :duration, :presence => true
  validates :price, :presence => true
  validates :title, :presence => true

  has_many  :notes, { :class_name => "Note", :foreign_key => "service_id", :dependent => :destroy }

  has_many :patients, { :through => :notes, :source => :patient }
end
