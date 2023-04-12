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
  validates :address, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :phone_number, :presence => true

  has_many  :notes, { :class_name => "Note", :foreign_key => "patient_id", :dependent => :destroy }

  has_many :users, { :through => :notes, :source => :user }

  has_many :services, { :through => :notes, :source => :service }


  def self.search(query)
    if query.present?
      where("first_name LIKE :query OR last_name LIKE :query", query: "%#{query}%")
    else
      all
    end
  end

end
