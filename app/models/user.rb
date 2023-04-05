# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  admin           :boolean
#  email           :string
#  first_name      :string
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  has_secure_password

  has_many :notes, { :class_name => "Note", :foreign_key => "user_id", :dependent => :destroy }

  has_many :patients, { :through => :notes, :source => :patient }

  has_many :conversations, { :class_name => "Conversation", :foreign_key => "owner_id", :dependent => :destroy }

  has_many :sent_messages, { :class_name => "Message", :foreign_key => "sender_id", :dependent => :destroy }

  has_many :received_messages, { :class_name => "Message", :foreign_key => "recipient_id", :dependent => :destroy }
end
