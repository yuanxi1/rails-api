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
    
    
         private 
        def tag_params
            params.require(:tag).permit(:name)
        end
    end 
end 
end 