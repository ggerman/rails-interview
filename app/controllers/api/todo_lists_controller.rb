module Api
  class TodoListsController < ApplicationController
    skip_before_action :verify_authenticity_token
    # GET /api/todolists
    def index
      @todo_lists = TodoListService.all
      respond_to :json
    end

    # GET /api/todolists/:id
    def show
      @todo_list = TodoListService.find(params[:id])
      respond_to :json
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Todo list not found' }, status: :not_found
    end

    # POST /api/todolists
    def create
      @todo_list = TodoListService.create(todo_list_params)
      if @todo_list.persisted?
        render :show, status: :created
      else
        render json: { errors: @todo_list.errors.full_messages }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/todolists/:id
    def update
      @todo_list = TodoListService.update(params[:id], todo_list_params)
      if @todo_list.errors.none?
        render :show, status: :ok
      else
        render json: { errors: @todo_list.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Todo list not found' }, status: :not_found
    end

    # DELETE /api/todolists/:id
    def destroy
      TodoListService.destroy(params[:id])
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Todo list not found' }, status: :not_found
    end

    private

    def todo_list_params
      params.require(:todo_list).permit(:name)
    end
  end
end
