class Task < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by(name:name).tasks

  end

  def set_tag_list(tag_list, user_id)
    self.tags = tag_list.map do |tag_name|
      tag = Tag.where(name: tag_name, user_id: user_id).first
      tag ||= Tag.create(name: tag_name, user_id: user_id)
    end

  end 
end
