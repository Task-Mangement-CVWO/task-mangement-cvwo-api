class User < ApplicationRecord
  has_secure_password
  validates_presence_of :username
  validates_presence_of :password
  validates_uniqueness_of :username
  validates :password, length: { in: 6..20 }

  has_many :tasks, through: :tasks
  has_many :tags, through: :tags
  has_many :task_tags, through: :task_tags
end
