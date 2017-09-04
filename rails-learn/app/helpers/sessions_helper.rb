module SessionsHelper
  #登陆指定的用户
  def log_in(user)
    session[:user_id] = user.id
    #session 方法与 8.1.1 节生成的 Sessions 控制器没有关系。
    #这么做会在用户的浏览器中创建一个临时cookie，浏览器关闭后立即失效。内容是加密后的用户 ID。在后续的请求中，可以使用 session[:user_id] 取回这个 ID
  end
  # 以下定义应该可以，不过如果在一个页面中多次调用 current_user 方法，会多次查询数据库。所以，我们要使用一种 Ruby 习惯写法，把 User.find_by 的结果存储在实例变量中，只在第一次调用时查询数据库，后续再调用直接返回实例变量中存储的值：
  # def current_user
  #   Usr.find_by(id: session[:user_id])
  # end

  #current_user 法可用于编写类似下面:
  # = current_user.name 
  # redirect_to current_user 
  # def current_user
  #   if @current_user.nil?
  #     @current_user = User.find_by(id: session[:user_id])
  #   else
  #     @current_user
  #   end
  #   ## @current_user ||= User.find_by(id: session[:user_id])
  # end
  def current_user#添加cookie 的做法
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id) 
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
    
  end
  # 如果用户已登录，返回 true，否则返回 false
  def logged_in?
    !current_user.nil?
  end
  ## 退出当前用户
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil;
  end
  # 忘记持久会话
  def forget(user)
    user.forget 
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  # 在持久会话中记住用户
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

end
