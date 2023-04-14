# == Schema Information
#
# Table name: chats
#
#  id         :integer          not null, primary key
#  content    :string
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  prompt_id  :string
#
class Chat < ApplicationRecord

  validates :content, presence: true
  validates :role, presence: true
end
