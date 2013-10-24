class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  paginates_per 15

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }  
end
