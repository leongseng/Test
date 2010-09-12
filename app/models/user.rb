class User < ActiveRecord::Base
  attr_accessible :login, :email, :password, :password_confirmation, :openid_identifier
  validates_presence_of     :login, :directory_server
  validates_uniqueness_of   :login
  validates_confirmation_of :password

#  acts_as_authentic :validate_password_field => false
  acts_as_authentic do |c|
        c.logged_in_timeout = 1.minutes # for available options see documentation in: Authlogic::ActsAsAuthentic
  end
  
  protected
    def valid_ldap_credentials?(password_plaintext)
      # try to authenticate against the LDAP server
      ldap = Net::LDAP.new
      ldap.host = LDAP_HOST
      # first create the username/password strings to send to the LDAP server
      # add the domain so it looks like COMPANY\firstname.lastname
      ldap.auth "#{LDAP_DOMAIN}\\" + self.login, password_plaintext
      ldap.bind # will return false if authentication is NOT successful
    end
    
end
