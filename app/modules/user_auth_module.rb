module UserAuthModule
  def generate_refresh_token
    loop do
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end

  def find_client_app
    client_id = params[:client_id] || Doorkeeper::Application.find_by(name: 'Postman')&.uid
    @client_app = Doorkeeper::Application.find_by(uid: client_id)

    unless @client_app
      render json: { error: 'Invalid client ID' }, status: 403
    end
  end

  def create_access_token()
    Doorkeeper::AccessToken.create(
      resource_owner_id: @user.id,
      application_id: @client_app.id,
      refresh_token: generate_refresh_token,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      scopes: ''
    )
  end

  def render_user_with_token(access_token)
    combined_data = {
      id: @user.id,
      email: @user.email,
      access_token: access_token.token,
      refresh_token: access_token.refresh_token,
      expires_in: access_token.expires_in,
    }

    render json: combined_data, status: :created, location: api_v1_user_url(@user)
  end
end