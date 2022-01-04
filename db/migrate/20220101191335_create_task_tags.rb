class CreateTaskTags < ActiveRecord::Migration[7.0]
  def change
    create_table :task_tags do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :tag, foreign_key: true
      t.belongs_to :task, foreign_key: true

      t.timestamps
    end
  end
end
