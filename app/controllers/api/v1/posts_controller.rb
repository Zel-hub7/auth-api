class Api::V1::PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  
    # GET /api/v1/posts
    def index
      @posts = Post.all
      render json: @posts
    end
  
    # GET /api/v1/posts/:id
    def show
      @post = Post.find(params[:id])
      render json: @post
    end
  
    # POST /api/v1/posts
    def create
      @post = current_user.posts.build(post_params)
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /api/v1/posts/:id
    def update
      @post = current_user.posts.find(params[:id])
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /api/v1/posts/:id
    def destroy
      @post = current_user.posts.find(params[:id])
      @post.destroy
      head :no_content
    end
  
    private
  
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
  