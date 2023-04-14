# == Schema Information
#
# Table name: prompts
#
#  id         :integer          not null, primary key
#  topic      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Prompt < ApplicationRecord

  validates :topic, presence: true

belongs_to :user


end
