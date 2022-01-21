class Tag < ApplicationRecord
  has_many :task_tags, through: :task_tags
  has_one :user

  validates_presence_of :title
  validates_presence_of :user_id
end
