class RelationshipsController < ApplicationController

  before_filter :authenticate

  def create
    # figured out what param to use via: raise params.inspect
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js # by default, looks for views/relationships/create.js.erb
    end
  end


#   def destroy
#     @user = Relationship.find(params[:id]).followed
#     current_user.unfollow!(@user)
#     respond_to do |format|
#       format.html { redirect_to @user }
#       format.js
#     end
#   end

  # Following caused _follow partial to be triggered (i.e. at render time, it
  # already sees users as being unfollowed, and so wants to show follow button, causing
  # error).  Problem was we need to set @user for use in templates; doing so fixes things.
  def destroy
    relationship = Relationship.find_by_id(params[:id])
    current_user.unfollow!(relationship.followed)
    @user = relationship.followed
    respond_to do |format|
      format.html { redirect_to @user }
      format.js # by default, looks for views/relationships/destroy.js.erb
    end
  end

end
