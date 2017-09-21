module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user

    def connect
      self.user = get_verified_user
    end

    def get_verified_user
      if verified_user = User.find_by(id: cookies.encrypted[:id])
        verified_user
      end
      nil
    end
  end
end
