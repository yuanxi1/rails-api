module Api
    module V1
       class TagsController < ApplicationController
         def index
            tags = current_user.tags
            render json: TagSerializer.new(tags), status: :ok #what should the status be?
         end
    
         def create
             tag = current_user.tags.create(tag_params)
             if tag.save
                render json: TagSerializer.new(tag), status: :ok
             else
                render json:{ error: 'Unable to add tag' }, status: 400
             end 
    
         end 
    
         def update
          tag = Tag.find(params[:id])
          tag.update(tag_params)
          if tag.save
             render json: TagSerializer.new(tag), status: :ok
          else
             render json:{ error: 'Unable to update tag' }, status: 400
          end 
         end
    
         def destroy
          tag = Tag.find(params[:id])
          id = tag.id.to_s
          if tag.destroy
             render json: {id: id}, status: :ok
          else 
             render json: {error: 'unable to delete'}, status: 400
          end
         end 
    
        #  def search 
        #   filtered_tasks = Task.left_outer_joins(:tags).where(tag_condition).where(title_condition).where(duefrom_condition).where(dueto_condition).distinct.order(duedate: :asc)
        #   # filtered_tasks = Task.where("title = ?", params[:title])
        #   if filtered_tasks
        #      render json: TaskSerializer.new(filtered_tasks), status: :ok
        #   else 
        #      render json: {error: 'task not found'}, status: 400
        #   end
        #  end
    
         private 
        def tag_params
            params.require(:tag).permit(:name)
        end
        # def title_condition
        #   ['title= ?', params[:title]] unless params[:title].blank?
        # end
        # def tag_condition
        #   ['tags.name= ?', params[:tag_name]] unless params[:tag_name].blank?
        # end
    
        # def duefrom_condition
        #   ['duedate>= ?', params[:date_from]] unless params[:date_from].blank?
        # end
        # def dueto_condition
        #   ['duedate<= ?', params[:date_to]] unless params[:date_to].blank?
        # end
    end 
    end 
    end 