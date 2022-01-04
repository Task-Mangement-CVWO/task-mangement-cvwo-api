class TaskTag < ApplicationRecord
  has_one :user
  has_one :tag
  has_one :task

  validates_associated :user
  validates_associated :tag
  validates_associated :task
  validates_presence_of :user_id
  validates_presence_of :tag_id
  validates_presence_of :task_id
  validates_uniqueness_of :task_id, scope: %i[tag_id user_id]
end
