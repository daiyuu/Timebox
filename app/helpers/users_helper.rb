module UsersHelper
  def admin_user?
    current_user.id = 1
    current_user.name = '河原大雄'
    current_user.email = 'k.daiyuu.bb@gmail.com'
  end
end
