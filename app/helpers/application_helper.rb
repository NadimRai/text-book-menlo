module ApplicationHelper
	def avatar_url(user)
    	hash = Digest::MD5.hexdigest(user.email.downcase)
    	"https://www.gravatar.com/avatar/#{hash}"
  	end

end
