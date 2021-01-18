module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def inclination(num, enot, enota, enotov)
    return enotov if (11..14).include?(num % 100)

    ostatok = num % 10

    return enot if ostatok == 1

    return enota if [2, 3, 4].include?(ostatok)

    enotov
  end
end
