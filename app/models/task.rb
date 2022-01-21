class Task < ApplicationRecord
  has_one :user
  has_many :task_tags, through: :task_tags

  validates_presence_of :user_id
  validates_presence_of :title
  validates_presence_of :dueDate
  validates_presence_of :state
  validates :state,
            inclusion: {
              in: ['In Progress', 'To Do', 'Completed', 'Deleted'],
              message: '%{value} is not a valid state'
            }
end
