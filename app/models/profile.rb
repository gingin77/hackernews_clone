class Profile
  def self.username(name)
    User.find_by(name: name)
  end
end
