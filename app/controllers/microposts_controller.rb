class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def claim
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.claimed?
      # unclaim
      if current_user?(@micropost.claimer)
        @micropost.claimer = nil
        flash[:notice] = "Unclaimed #{@micropost.content}"
      else
        return
      end
    else
      @micropost.claimer = current_user
      flash[:notice] = "Claimed #{@micropost.content}"
    end
    @micropost.save
    redirect_to root_url
  end

  private

 def micropost_params
      params.require(:micropost).permit(:content, :picture, :location, :claimed)
    end


    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
