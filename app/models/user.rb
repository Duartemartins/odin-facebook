# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # - RELATIONS
  has_one_attached :avatar, dependent: :destroy
  has_many :friendships, dependent: :destroy  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy


  accepts_nested_attributes_for :posts
  # extra stuff:

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name # assuming the user model has a name
      user.avatar = auth.info.avatar # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails,
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
    end
  end

  def pending_friends # user sent friend request but not yet accepted by friend. Returns friend that received the friend request.
    Friendship.where("user_id = ? AND status = ?", self.id, "requested").pluck(:friend_id)
  end
  def requested_friends # user received friend request but not yet accepted by user. Returns user that sent the friend request.
    Friendship.where("friend_id = ? AND status = ?", self.id, "requested").pluck(:user_id)
  end
  def friends
    Friendship.where(status:"accepted").where('user_id = ? OR friend_id = ?', self.id, self.id)
  end
end
