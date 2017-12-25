require 'em-hiredis'

class UrlShortenerController < ApplicationController

  def shorten
    redis = EM::Hiredis.connect
    token = SecureRandom.hex(4)
    redis.set(token, params[:longUrl])
    p "#{request.base_url}/#{token}"
    render json: { url: "#{request.base_url}/#{token}" }

    #redis.set(token, params[:longUrl]).callback {
    #  render json: { url: "#{request.base_url}/#{token}" }
    #}

  end

  def expand
    redis = EM::Hiredis.connect
    long_url = ''
    redis.get(params[:token]) { |value|
      long_url = value
    }
    redirect_to long_url, status: :moved_permanently


    #redis.get(params[:token]) { |value|
    #  redirect_to value, status: :moved_permanently
    #}
  end

end
