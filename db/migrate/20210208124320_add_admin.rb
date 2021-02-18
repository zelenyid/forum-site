class AddAdmin < ActiveRecord::Migration[6.1]
  def change
    User.create! do |u|
      u.name      = 'admin'
      u.email     = 'test_admin@test.com'
      u.password  = 'password'
      u.admin     = true
    end
  end
end
