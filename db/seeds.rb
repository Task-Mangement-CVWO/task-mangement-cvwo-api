# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

User.create(
  [
    {
      username: 'testUser1',
      password: '88888888',
      password_confirmation: '88888888'
    },
    {
      username: 'testUser2',
      password: '88888888',
      password_confirmation: '88888888'
    },
    {
      username: 'testUser3',
      password: '88888888',
      password_confirmation: '88888888'
    }
  ]
)

Tag.create(
  [
    { title: 'School', user_id: 1 },
    { title: 'Chores', user_id: 1 },
    { title: 'Work', user_id: 1 },
    { title: 'Miscellaneous', user_id: 1 }
  ]
)

Task.create(
  [
    {
      user_id: 1,
      title: 'CS1101S Mission 2',
      description: 'Weekly missions finish by Monday',
      dueDate: Time.new(2022, 2, 1),
      state: 'In Progress'
    },
    {
      user_id: 1,
      title: 'ST1131 Tutorial',
      description: 'Finish on R Studio',
      dueDate: Time.new(2022, 3, 1),
      state: 'To Do'
    },
    {
      user_id: 1,
      title: 'CS1231S Tutorial',
      description: 'Pain, this is just pain',
      dueDate: Time.new(2022, 2, 3),
      state: 'To Do'
    },
    {
      user_id: 1,
      title: 'IS1103 Quiz',
      description: 'Finish by Friday',
      dueDate: Time.new(2022, 2, 5),
      state: 'To Do'
    }
  ]
)

TaskTag.create(
  [
    { user_id: 1, task_id: 1, tag_id: 1 },
    { user_id: 1, task_id: 2, tag_id: 2 },
    { user_id: 1, task_id: 3, tag_id: 1 },
    { user_id: 1, task_id: 4, tag_id: 3 },
    { user_id: 1, task_id: 4, tag_id: 1 }
  ]
)
