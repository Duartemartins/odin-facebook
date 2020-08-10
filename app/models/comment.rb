class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable
  accepts_nested_attributes_for :likes
  validates :content, presence: true
end
