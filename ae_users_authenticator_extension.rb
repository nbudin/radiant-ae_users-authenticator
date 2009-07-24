# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class AeUsersAuthenticatorExtension < Radiant::Extension
  version "1.0"
  description "Provide authentication using ae_users"
  url "http://ae-rails-plugins.googlecode.com"

  # define_routes do |map|
  #   map.connect 'admin/ae_users_authenticator/:action', :controller => 'admin/ae_users_authenticator'
  # end
  
  def activate
    # admin.tabs.add "Ae Users Authenticator", "/admin/ae_users_authenticator", :after => "Layouts", :visibility => [:all]
    User.send :include, AeUsersAuthenticator
  end
  
  def deactivate
    # admin.tabs.remove "Ae Users Authenticator"
  end
 
end
