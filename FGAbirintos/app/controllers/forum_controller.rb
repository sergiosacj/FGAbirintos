class ForumController < ApplicationController
  
  def index
    @users = User.all
  end

end
