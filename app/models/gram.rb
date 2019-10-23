class Gram < ApplicationRecord
  validates :message, presence: true
  validates :picture, presence: true
  has_many :comments #gram model should have a has many relationship with comments

  mount_uploader :picture, PictureUploader

  belongs_to :user
end
