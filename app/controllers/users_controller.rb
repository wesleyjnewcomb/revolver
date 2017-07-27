class UsersController < ApplicationController
  # before_action :set_users, only: [:index]

  def index
     unless current_user && current_user.admin?
       redirect_to root_url
     end
     @users = User.all


  end

  def destroy
    binding.pry
   @user = User.find(params[:id])

   if @user.destroy
       redirect_to root_url, notice: "User deleted."
   end
 end
end
