class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(payload)
    # payload = {beef: 'steak'}
    # JWT.encode(payload, 'my_secret')=> "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ.OIsGX8Y2XTQk6gF_4LuMRrHrkNqiVAe9Un4A5KlqX8E"

    JWT.encode(payload, 'my_secret')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decode_token
    # token = "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ.OIsGX8Y2XTQk6gF_4LuMRrHrkNqiVAe9Un4A5KlqX8E"
    # JWT.decode(token, 'my_secret') => [{"beef"=>"steak"}, {"alg"=>"HS256"}]
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decode_token
      # decoded_token=> [{"user_id"=>2}, {"alg"=>"HS256"}]
      # or nil if we can't decode the token
      user_id = decode_token[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
