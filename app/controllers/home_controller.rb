class HomeController < ApplicationController
  before_action :authenticate_user!

  def root
    redirect_to posts_path
  end

end
