class Api::V1::SessionsController < ApplicationController
  def create
    # 如果测试环境，code 就永远为 123456
    if Rails.env.test?
      # 直接验证码必须为 123456
    else
      #
    end
  end
end
