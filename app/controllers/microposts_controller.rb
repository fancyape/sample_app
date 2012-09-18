class MicropostsController < ApplicationController
  
  # Filters are methods that are run before, after or “around” a controller action. Methods are below
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
#  before_filter :reply_to_user, only: :create

  def create
     @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Mikeropost created!"
      redirect_to root_path
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to root_path
  end
  
   private

    def correct_user
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?
    end
    
    def reply_to_user
      if in_reply_to = @micropost.content.match(/\A(@[\w+\-.])\z/i)
      @other_user = User.where(name: reply_to.to_s[1..-1])
        if @other_user && current_user.followed_users.includes(@other_user)
        @micropost.in_reply_to = @other_user.id
        end
      end
    end
end