class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @player = Player.find_by(username: player_login_params[:username])
    #Player#authenticate comes from BCrypt
    if @player && @player.authenticate(player_login_params[:password])
      # encode token comes from ApplicationController
      token = encode_token({ player_id: @player.id })
      render json: { player: PlayerSerializer.new(@player), jwt: token, success: true }, status: :accepted
    else
      render json: { message: "Invalid username or password" }, status: :unauthorized
    end
  end

  private

  def player_login_params
    # params { player: {username: 'oren', password: 'hi' } }
    params.require(:player).permit(:username, :password)
  end
end
