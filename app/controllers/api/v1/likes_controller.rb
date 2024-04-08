# app/controllers/api/v1/likes_controller.rb
class Api::V1::LikesController < ApplicationController
    before_action :authenticate_user!
  
    # GET /api/v1/posts/:post_id/likes
    def index
      @post = Post.find(params[:post_id])
      @likes = @post.likes
      render json: @likes
    end
  
    # POST /api/v1/posts/:post_id/likes
    def create
      @post = Post.find(params[:post_id])
      @like = @post.likes.new(user: current_user)
      if @like.save
        render json: @like, status: :created
      else
        render json: @like.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/posts/:post_id/likes/:id
    def destroy
      @like = current_user.likes.find(params[:id])
      @like.destroy
      head :no_content
    end
end
  