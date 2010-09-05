class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :login,               :null => false                
      t.string    :email,               :null => false               
      t.string    :crypted_password                      # can be null if using Directory Server for Authentication              
      t.string    :password_salt                         # can be null if using Directory Server for Authentication
      t.string    :persistence_token,   :null => false   # required
      t.string    :single_access_token, :null => false   # optional, see Authlogic::Session::Params
      t.string    :perishable_token,    :null => false   # optional, see Authlogic::Session::Perishability

    # Magic columns, just like ActiveRecord's created_at and updated_at. These are automatically maintained by Authlogic if they are present.
    # optional, see Authlogic::Session::MagicColumns
      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip
      t.string    :directory_server,     :null => false, :default => "local"   # LDAP Host if specified
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
