class CreateHackers < ActiveRecord::Migration
  def self.up
    create_table :hackers do |t|
      t.string    :email,               :null => false                # optional, you can use login instead, or both
      t.string    :name
      t.string    :gitemail
      t.string    :crypted_password,    :null => false                # optional, see below
      t.string    :password_salt,       :null => false                # optional, but highly recommended
      t.string    :persistence_token,   :null => false                # required
      t.string    :perishable_token,    :null => false                # optional, see Authlogic::Session::Perishability
      t.datetime  :current_login_at                                   # optional, see Authlogic::Session::MagicColumns
      t.datetime  :last_login_at                                      # optional, see Authlogic::Session::MagicColumns
      t.timestamps
    end
  end

  def self.down
    drop_table :hackers
  end
end
