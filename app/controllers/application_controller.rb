class ApplicationController < ActionController::API
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
end
