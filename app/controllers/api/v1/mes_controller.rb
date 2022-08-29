class Api::V1::MesController < ApplicationController
  def show
    # get jwt from header
    header = request.headers["Authorization"]
    jwt = header.split(' ')[1] rescue ''
    # decode jwt
    payload = JWT.decode jwt, Rails.application.credentials.hmac_secret, true, { algorithm: 'HS256' } rescue nil
    return head 400 if payload.nil?
    # get user_id from payload
    user_id = payload[0]['user_id'] rescue nil
    # get user from user_id
    user = User.find user_id
    return head 404 if user.nil?
    # render user
    render json: { resource: user }
  end
end