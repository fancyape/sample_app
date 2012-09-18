class Micropost < ActiveRecord::Base
  
  attr_accessible :content, :in_reply_to_id
  belongs_to :user
  belongs_to :in_reply_to, class_name: "User"
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  
  
   
 
  default_scope order: 'microposts.created_at DESC'

  
  

  private
  # never put your arguments directly inside the conditions string, use this format such as  "user_id = ? OR user_id = ?", user_id: user
  # or use place holders such as "user_id = :user_id", user_id: = user
  # Returns microposts from the users being followed by the given user including replies.
  def self.from_users_followed_by(user)  

    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id "
                       
    Micropost.where("user_id IN (#{followed_user_ids}) AND (in_reply_to_id IS NULL OR in_reply_to_id = 
    :user_id) OR user_id = :user_id OR in_reply_to_id = :user_id", user_id: user)                
  end    
end