class UsersController < ApplicationController
  def new
    #debugger
    @user = User.new;

  end
  def show
    @user = User.find(params[:id]) 
    #debugger
    #debugger #debugger 方法加到应用中,Rails 服务器的输出中会显示 byebug 提示符
  end
  def create
    @user = User.new(user_params);
    if @user.save
      redirect_to @user 
      #不过，也可以写成：redirect_to user_url(@user)
      #创建成功后，会重定向到一个地址

    else
      render 'new'
    end
  end
  private
    def user_params
      params.require(:user).permit(:name, :email, :password,:password_confirmation)
    end
end
