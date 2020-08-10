# frozen_string_literal: true

class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_friendship, only: %i[show edit update destroy]

  # GET /friendships
  # GET /friendships.json

  def new
    @friendship = Friendship.new
  end

  def index
    @friendships = Friendship.all
  end

  def create
    @friendship = Friendship.create(friendship_params)

    if @friendship.save
      flash[:notice] = 'Friend request sent.'
      redirect_to users_path
    else
      flash[:error] = 'Unable to send friend request.'
      redirect_to users_path
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = 'Removed friendship.'
    redirect_to current_user
  end

  def update
    respond_to do |format|
      if Friendship.accept(@friendship.friend, @friendship.user)
        format.html { redirect_to friendships_path, notice: 'Friend request was successfully accepted.' }
        format.json { render :show, status: :ok, location: @friend_request }
      else
        format.html { render :edit }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :status)
  end
end
