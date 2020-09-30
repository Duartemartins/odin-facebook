# frozen_string_literal: true

class Friendship < ApplicationRecord
  # - RELATIONS
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
  attribute :status, :string, default: 'requested'

  # - VALIDATIONS
  validates_presence_of :user_id, :friend_id, :status
  validate :user_is_not_equal_friend
  validates_uniqueness_of :user_id, scope: :friend_id

  private

  def self.accept(user, friend)
    transaction do
      accepted_at = Time.now
      accept_friendship(user, friend, accepted_at)
    end
  end

  def self.accept_friendship(current_user, friend, accepted_at)
    request = find_by_user_id_and_friend_id(current_user, friend)
    request.status = 'accepted'
    request.accepted_at = accepted_at
    request.save!
  end

  def user_is_not_equal_friend
    errors.add(:friend, "can't be the same as the user") if user == friend
  end

  # def self.request(current_user, friend)
  #   unless (current_user == friend) || Friendship.exists?(current_user, friend)
  #       self.class.create(user: current_user, friend: friend, status: 'pending')
  #       self.class.create(user: friend, friend: current_user, status: 'requested')
  #   end
  # end
end
