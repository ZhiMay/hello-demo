class SessionsController < ApplicationController
  def new
  end

  ## 除了 nil 和 false 之外的所有对象都被视作真值
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      ## 登陆用户，然后重定向到用户的资料页面
      log_in user #创建临时会话,相当于cookie 
      params[:session][:remember_me] == '1' ? remember(user) : forget(user) #记住密码
      redirect_to user #user_url(user)
    else
      #创建一个错误信息
      #flash[:danger] = 'Invalid email/password combination'
      #把 flash 换成特殊的 flash.now。flash.now 专门用于在重新渲染的页面中显示闪现消息。
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  #销毁会话（退出用户）
  def destroy
    log_out
    redirect_to root_url
  end

end
