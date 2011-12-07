Rails.application.config.to_prepare do

  User.class_eval do
    has_many :tray_positions, :order => "position", :include => {:asset => :classifications}
  end

end
