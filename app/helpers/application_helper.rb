module ApplicationHelper

  def set_thubm(user)
    if user.avatar.file
      return user.avatar_url(:thumb)
    else
      return "hito.jpg"
    end
  end
end
