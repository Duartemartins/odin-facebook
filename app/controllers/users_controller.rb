# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update destroy]
  # before_action :require_user, only: :index

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(:first_name).includes(:friendships).paginate(page: params[:page], per_page: 30)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 3)
  end

  # GET /users/new
  def new
    @user = User.new
    @avatar = @user.avatar.attach(params[:avatar])
    @posts = @user.posts
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @avatar = @user.avatar.attach(params[:avatar])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        
        format.html { redirect_to @user, notice: 'User was successfully created.'}
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.likes.reload
    @user.destroy
    respond_to do |format|
      format.html { redirect_to unauthenticated_root_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:friend_id, :email, :first_name, :last_name, :avatar)
  end
end
