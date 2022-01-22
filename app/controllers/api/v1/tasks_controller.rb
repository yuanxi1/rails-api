module Api
module V1
   class TasksController < ApplicationController
     def index
        tasks = current_user.tasks
        render json: TaskSerializer.new(tasks), status: :ok #what should the status be?
     end

     def show
        tasks = current_user.tasks
        render json: TaskSerializer.new(tasks), status: :ok #what should the status be?
     end 

     def create
         task = current_user.tasks.create(task_params)
         if task.save
            task.set_tag_list(tag_list, current_user.id)
            render json: TaskSerializer.new(task), status: :ok
         else
            render json:{ error: task.errors.full_messages[0] }, status: 400
         end 

     end 

     def update
      task = Task.find(params[:id])
      task.update(task_params)
      if task.save
         if tag_list
            task.set_tag_list(tag_list, current_user.id)
         end
         render json: TaskSerializer.new(task), status: :ok
      else
         render json:{ error: 'Unable to update task' }, status: 400
      end 
     end

     def destroy
      task = Task.find(params[:id])
      id = task.id.to_s
      if task.destroy
         render json: {id: id}, status: :ok
      else 
         render json: {error: 'unable to delete'}, status: 400
      end
     end 

     def search 
      filtered_tasks = Task.left_outer_joins(:tags)
      if params[:show_overdue] == 'true'
         filtered_tasks = 
         (filtered_tasks.where(tag_condition).where(title_condition).where(duefrom_condition).where(dueto_condition))
         .or(
            filtered_tasks.where('duedate<= ? AND completed=?', params[:date_to], false)
         ).distinct.order(duedate: :asc)
      else 
         filtered_tasks = 
         (filtered_tasks.where(tag_condition).where(title_condition).where(duefrom_condition).where(dueto_condition))
         .distinct.order(duedate: :asc)
      end 
      if filtered_tasks
         render json: TaskSerializer.new(filtered_tasks), status: :ok
      else 
         render json: {error: 'task not found'}, status: 400
      end
     end

     private 
    def task_params
        params.require(:task).permit(:title, :description, :completed, :duedate)
    end
    def tag_list
      params[:task][:tag_list]
    end

    def title_condition
      ['lower(title) LIKE ?', '%'+params[:title].downcase+'%'] unless params[:title].blank?
    end
    def tag_condition
      ['tags.name= ?', params[:tag_name]] unless params[:tag_name].blank?
    end

    def duefrom_condition
      ['duedate>= ?', params[:date_from]] unless params[:date_from].blank?
    end
    def dueto_condition
      ['duedate<= ?', params[:date_to]] unless params[:date_to].blank?
    end

    

end 
end 
end 