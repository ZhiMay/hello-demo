class UsersController < ApplicationController
  def new
    #debugger
    @user = User.new;

  end
  def show
    @user = User.find(params[:id]) 
    debugger
    #debugger #debugger 方法加到应用中,Rails 服务器的输出中会显示 byebug 提示符
  end
end
