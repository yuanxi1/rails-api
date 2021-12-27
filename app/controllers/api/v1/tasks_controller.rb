module Api
module V1
   class TasksController < ApplicationController
     def index
        tasks = current_user.tasks
        render json:{tasks: TaskSerializer.new(tasks)}, status: :ok #what should the status be?
     end

     def show
        tasks = current_user.tasks
        render json:{tasks: TaskSerializer.new(tasks)}, status: :ok #what should the status be?
     end 

     def create

     end 

     def update
     end

     def destroy
     end 

     private 
    def task_params
        params.require(:task).permit(:title, :description, :tag_list)
    end
end 
end 
end 