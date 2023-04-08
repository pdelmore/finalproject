# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class Message < ApplicationRecord
  validates :body, :presence => true

  belongs_to :sender, { :required => true, :class_name => "User", :foreign_key => "sender_id" }

  belongs_to :recipient, { :required => true, :class_name => "User", :foreign_key => "recipient_id" }


  def thread_key
    if sender_id < recipient_id
      "#{sender_id}-#{recipient_id}"
    else
      "#{recipient_id}-#{sender_id}"
    end
  end
end
