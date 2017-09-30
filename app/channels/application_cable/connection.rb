module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user

    def connect
      self.user = verified_user
    end

    def verified_user
      if (current_verified_user = User.find_by(id: cookies.encrypted[:id]))
        current_verified_user
      end
      nil
    end
  end
end
