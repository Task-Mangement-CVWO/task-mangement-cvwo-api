class TaskController < ApplicationController
  before_action :set_task,
                only: %i[getOneTaskById updateOneTaskById deleteOneTaskById]
  def getAllTasks
    begin
      instances = Task.where(user_id: @user.id)
      current_tags = TaskTag.where(user_id: @user.id)
      render json: { data: instances, tag: current_tags }
      return
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Record not found' }, status: 400
      return
    rescue ActiveRecord::ActiveRecordError => e
      render json: { message: e }, status: 400
      return
    rescue => e
      render json: { message: e }, status: 400
      return
    rescue Exception => e
      render json: { message: e }, status: 400
      return
      raise
    end
  end

  def getOneTaskById
    current_tags = TaskTag.where(task_id: @task.id, user_id: @user.id)
    render json: { data: @task, tag: current_tags}
    return
  end

  def updateOneTaskById
    begin
      ActiveRecord::Base.transaction do
        tags = params['tags']
        update_params = params.permit(:title, :description, :dueDate, :state)
        updated_entity = @task.update(update_params) if update_params
        to_delete = []
        to_create = []
        current_tags = TaskTag.where(task_id: @task.id, user_id: @user.id)
        if tags
          new_tags = tags.uniq
          old_tags = TaskTag.where(task_id: @task.id, user_id: @user.id)
          old_tags = old_tags.map { |val| val['tag_id'] } if old_tags
          update_tags = compare_tags(new_tags, old_tags)
          to_delete = update_tags[0]
          to_create = update_tags[1]
          delete_tags(to_delete, @task) if to_delete.length > 0
          create_tags(to_create, @task) if to_create.length > 0
        end
        render json: {
                 data: {
                   updated_entity: @task,
                   tag: current_tags
                 }
               }
      end
      return
    rescue ActiveRecord::ActiveRecordError => e
      render json: { message: e }, status: 400
      return
    rescue => e
      render json: { message: e }, status: 400
      return
    rescue Exception => e
      render json: { message: e }, status: 400
      return
      raise
    end
  end

  def createOneTask
    begin
      ActiveRecord::Base.transaction do
        tags = params['tags']
        description = params['description'] || ''
        new_entity =
          Task.create!(
            user_id: @user.id,
            title: params['title'],
            description: description,
            dueDate: params['dueDate'],
            state: params['state']
          )
        tag_instances = []
        if tags && tags.length() > 0
          unique_instances = tags.uniq
          tag_instances = create_tags(unique_instances, new_entity)
        end
        render json: { data: { new_entity: new_entity, tags: tag_instances } }
      end
      return
    rescue ActiveRecord::ActiveRecordError => e
      render json: { message: e }, status: 400
      return
    rescue => e
      render json: { message: e }, status: 400
      return
    rescue Exception => e
      render json: { message: e }, status: 400
      return
      raise
    end
  end

  def deleteOneTaskById
    begin
      ActiveRecord::Base.transaction do
        TaskTag.destroy_by(task_id: @task.id, user_id: @user.id)
        @task.destroy
      end
      render json: { data: @task.id }
      return
    rescue ActiveRecord::ActiveRecordError => e
      render json: { message: e }, status: 400
      return
    rescue => e
      render json: { message: e }, status: 400
      return
    rescue Exception => e
      render json: { message: e }, status: 400
      return
      raise
    end
  end

  private

  def set_task
    begin
      @task = Task.find(params[:id])
      return
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Record not found' }, status: 400
      return
    rescue Exception => e
      render json: { message: e }, status: 400
      return
      raise
    end
  end

  #input ( tag ids [1, 2, 3] )
  def create_tags(tags, task)
    tag_instances =
      tags.map do |tag_id|
        { tag_id: tag_id, user_id: @user.id, task_id: task.id }
      end
    new_tags = TaskTag.insert_all(tag_instances)
    return new_tags
  end

  #input ( tag ids [1, 2, 3] )
  def delete_tags(tags, task)
    TaskTag.where(task_id: task.id, user_id: @user.id, tag_id: tags).delete_all
    return
  end

  #return [[to_delete: tag_id], [to_create: tag_id] ]
  def compare_tags(new_tags, old_tags)
    to_delete = []
    to_create = []

    #generate to_create
    for new_tag_id in new_tags
      to_create_id = true
      for old_tag_id in old_tags
        to_create_id = false if new_tag_id == old_tag_id
      end
      to_create.push(new_tag_id) if to_create_id
    end

    #generate to_delete
    for old_tag_id in old_tags
      to_delete_id = true
      for new_tag_id in new_tags
        to_delete_id = false if new_tag_id == old_tag_id
      end
      to_delete.push(old_tag_id) if to_delete_id
    end
    return to_delete, to_create
  end
end
