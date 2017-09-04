class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
    render html:"hello,world"
  end
  include SessionsHelper #(该方法可以在) #引入helper 方法，可以在controller 使用
end
