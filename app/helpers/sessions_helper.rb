module SessionsHelper

# ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_owner.nil?
  end

end
