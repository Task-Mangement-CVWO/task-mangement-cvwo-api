# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_01_191335) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'tags', force: :cascade do |t|
    t.string 'title'
    t.bigint 'user_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_tags_on_user_id'
  end

  create_table 'task_tags', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'tag_id'
    t.bigint 'task_id'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['tag_id'], name: 'index_task_tags_on_tag_id'
    t.index ['task_id'], name: 'index_task_tags_on_task_id'
    t.index ['user_id'], name: 'index_task_tags_on_user_id'
  end

  create_table 'tasks', force: :cascade do |t|
    t.bigint 'user_id'
    t.string 'title'
    t.string 'description'
    t.string 'dueDate'
    t.string 'state'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['user_id'], name: 'index_tasks_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username'
    t.string 'password_digest'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'tags', 'users'
  add_foreign_key 'task_tags', 'tags'
  add_foreign_key 'task_tags', 'tasks'
  add_foreign_key 'task_tags', 'users'
  add_foreign_key 'tasks', 'users'
end
