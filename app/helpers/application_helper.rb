module ApplicationHelper
  def avatar_url(user, size)
    user = User.find(params[:id])
    gravatar_id = Digest::MD5.hexdigest(user.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
