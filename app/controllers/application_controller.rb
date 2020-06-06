class ApplicationController < ActionController::API
  def encode_token(payload)
    # payload = {beef: 'steak'}
    # JWT.encode(payload, 'my_secret')=> "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ.OIsGX8Y2XTQk6gF_4LuMRrHrkNqiVAe9Un4A5KlqX8E"

    JWT.encode(payload, 'my_secret')
  end

  def decode_token(token)
    # token = "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ.OIsGX8Y2XTQk6gF_4LuMRrHrkNqiVAe9Un4A5KlqX8E"
    # JWT.decode(token, 'my_secret') => [{"beef"=>"steak"}, {"alg"=>"HS256"}]

    JWT.decode(token, 'my_secret').first
  end
end
