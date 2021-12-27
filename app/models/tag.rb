class Tag < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tasks, through: :taggings
end
