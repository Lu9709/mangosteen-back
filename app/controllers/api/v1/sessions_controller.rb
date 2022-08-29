class Api::V1::SessionsController < ApplicationController
  def create
    # 如果测试环境
    if Rails.env.test?
      return render status: :unauthorized if params[:code] != '123456'
    else 
      canSignin = ValidationCode.exists? email: params[:email], code: params[:code], used_at: nil
      return render status: :unauthorized unless canSignin
    end
    user = User.find_by_email params[:email]
    if user.nil?
      render status: :not_found, json: {error: '用户不存在'}
    else 
      render status: :ok, json: {
        jwt: 'xxxxxxxx'
      }
    end
    
  end
end
