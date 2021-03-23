class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])

    render_not_found unless @user
  end
end
