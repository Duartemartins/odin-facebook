# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all.includes(:comments, :likes)
    
    # @like = Like.where(":user_id = current_user.id")
    @comment = Comment.new(user_id: params[:user_id])
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  @comments = @post.comments
  end

  # GET /posts/new
  def new
    @post = Post.new(post_params)
    @user = current_user
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    # @user = User.find(params[:user_id])
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to authenticated_root_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to authenticated_root_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, :user_id)
  end
end
