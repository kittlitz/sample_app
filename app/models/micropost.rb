# == Schema Information
# Schema version: 20110325004201
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true

  default_scope :order => "microposts.created_at DESC"

  scope :from_users_followed_by, lambda { |user| followed_by(user) }

  def self.followed_by(user)
    #followed_ids = user.following.map(&:id).join(", ")
    followed_ids = %(SELECT followed_id FROM relationships 
WHERE follower_id = :user_id)
    # 'where' is class method
    where("user_id IN (#{followed_ids}) OR user_id=:user_id",
          :user_id => user)
  end

end
