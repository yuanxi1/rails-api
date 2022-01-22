class Tag < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tasks, through: :taggings

  validates :name, presence: true
end
