module UsersHelper
<<<<<<< 2fbe0f15c0cae6b5e5234426d260d4f498922ea4
=======

>>>>>>> reset d5cf4dc
  def gravatar_for user, options = {size: Settings.user.size.length}
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def User.digest string
    cost =  if ActiveModel::SecurePassword.min_cost
              BCrypt::Engine::MIN_COST
            else BCrypt::Engine.cost
            end
    BCrypt::Password.create(string, cost: cost)
  end
end
