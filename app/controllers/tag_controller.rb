class TagController < ApplicationController
  before_action :set_tag,
                only: %i[getOneTagById updateOneTagById deleteOneTagById]
  def getAllTags
    begin
      instances = Tag.where(user_id: @user.id)
      render json: { data: instances }
      return
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Record not found' }, status: 400
      return
    rescue ActiveRecord::ActiveRecordError => e
      render json: { error: e }, status: 400
      return
    rescue => e
      render json: { error: e }, status: 400
      return
    rescue Exception => e
      render json: { error: e }, status: 400
      return
      raise
    end
  end

  def getOneTagById
    render json: { data: @tag }
    return
  end

  def updateOneTagById
    begin
      update_params = params.permit(:title)
      updated_entity = @tag.update(update_params)
      render json: { data: { updated_entity: @tag } }
      return
    rescue ActiveRecord::ActiveRecordError => e
      render json: { error: e }, status: 400
      return
    rescue => e
      render json: { error: e }, status: 400
      return
    rescue Exception => e
      render json: { error: e }, status: 400
      return
      raise
    end
  end

  def createOneTag
    begin
      new_entity = Tag.create!(user_id: @user.id, title: params['title'])
      render json: { data: { new_entity: new_entity } }
      return
    rescue ActiveRecord::ActiveRecordError => e
      render json: { error: e }, status: 400
      return
    rescue => e
      render json: { error: e }, status: 400
      return
    rescue Exception => e
      render json: { error: e }, status: 400
      return
      raise
    end
  end

  def deleteOneTagById
    begin
      ActiveRecord::Base.transaction do
        TaskTag.destroy_by(tag_id: @tag.id, user_id: @user.id)
        @tag.destroy
      end
      render json: { data: @tag.id }
      return
    rescue ActiveRecord::ActiveRecordError => e
      render json: { error: e }, status: 400
      return
    rescue => e
      render json: { error: e }, status: 400
      return
    rescue Exception => e
      render json: { error: e }, status: 400
      return
      raise
    end
  end

  private

  def set_tag
    begin
      @tag = Tag.find(params[:id])
      return
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Record not found' }, status: 400
      return
    rescue Exception => e
      render json: { error: e }, status: 400
      return
      raise
    end
  end
end
