class UsersController < ApplicationController
  def new
  end
  def show
    @user = User.find(params[:id]) 
    #debugger #debugger 方法加到应用中
  end
end
