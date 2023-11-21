if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: 'Postman', redirect_uri: '', scopes: '')
end