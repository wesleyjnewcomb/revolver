class UsersController < ApplicationController
  # before_action :set_users, only: [:index]

  def index
     @users = User.all
    #  @user = User.find(params[:id])
    #  @users.destroy
    #  @displays = User.ids
  end
  
  def destroy
   @user = User.find(params[:id])

   if @user.destroy
       redirect_to root_url, notice: "User deleted."
   end
 end
end
