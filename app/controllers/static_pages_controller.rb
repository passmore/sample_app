class StaticPagesController < ApplicationController
# http://stackoverflow.com/questions/8705769/nomethoderror-in-pagescontrollerhome
  def home
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.page(params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
