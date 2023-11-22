if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: 'Postman', redirect_uri: '', scopes: '')
end

User.create(user_name: 'admin', email: 'admin@email.com', password: 'password', is_admin: true)