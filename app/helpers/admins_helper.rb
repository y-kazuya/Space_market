module AdminsHelper
  def owner?
    current_user.owner == true
  end
end
