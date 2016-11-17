class StaticPagesController < ApplicationController

 def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def feed
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed_search_by(params[:term]).paginate(page: params[:page])
      render "home"
    else
      redirect_to root_path
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
