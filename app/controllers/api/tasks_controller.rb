module Api
  class TasksController < ApplicationController
    skip_before_action :verify_authenticity_token
    # GET /api/todolists/:todo_list_id/tasks
    def index
      @tasks = TaskService.all(params[:todo_list_id])
      respond_to :json
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Todo list not found' }, status: :not_found
    end

    # GET /api/todolists/:todo_list_id/tasks/:id
    def show
      @task = TaskService.find(params[:todo_list_id], params[:id])
      respond_to :json
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end

    # POST /api/todolists/:todo_list_id/tasks
    def create
      @task = TaskService.create(params[:todo_list_id], task_params)
      if @task.persisted?
        render :show, status: :created
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Todo list not found' }, status: :not_found
    end

    # PATCH/PUT /api/todolists/:todo_list_id/tasks/:id
    def update
      @task = TaskService.update(params[:todo_list_id], params[:id], task_params)
      if @task.errors.none?
        render :show, status: :ok
      else
        render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end

    # DELETE /api/todolists/:todo_list_id/tasks/:id
    def destroy
      TaskService.destroy(params[:todo_list_id], params[:id])
      head :no_content
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end

    # PATCH /api/todolists/:todo_list_id/tasks/:id/complete
    def complete
      @task = TaskService.complete(params[:todo_list_id], params[:id])
      render :show, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end

    private

    def task_params
      params.require(:task).permit(:name, :description, :completed)
    end
  end
end
