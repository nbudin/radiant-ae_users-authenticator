require 'vendor/plugins/ae_users/app/models/person'
require 'vendor/plugins/ae_users/app/models/account'
require 'vendor/plugins/ae_users/app/models/email_address'

module AeUsersAuthenticator
  def self.included(base)
    base.extend ClassMethods

    base.class_eval do
      class << self
        alias_method :old_authenticate, :authenticate
        alias_method :authenticate, :ae_users_login
      end
    end
  end

  module ClassMethods
    def ae_users_login(login, password)
      person = Person.find_by_email_address(login)
      return nil if person.nil?
      return nil if person.account.nil?
      return nil if not person.account.check_password(password)

      find_user person
    end

    def find_user(person)
      u = User.find_by_login(person.primary_email_address)
      if u.nil?
        return nil
      end

      u.name = person.name
      u.email = person.primary_email_address
      if u.save
        return u
      end
    end
  end
end
