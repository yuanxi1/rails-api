class Task < ApplicationRecord
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :title, presence: true
  validates :duedate, presence: true

  #find tags or create tags that do not exist, and set the tags for task 
  def set_tag_list(tag_list, user_id)
    self.tags = tag_list.map do |tag_name|
      tag = Tag.where(name: tag_name, user_id: user_id).first
      tag ||= Tag.create(name: tag_name, user_id: user_id)
    end

  end 
end
