require 'rails_helper'

RSpec.describe "ValidationCodes", type: :request do
  describe "验证码" do
    it "发送太频繁就会返回429" do
      post '/api/v1/validation_codes', params: { email: '919041098@qq.com' }
      expect(response).to have_http_status(200)
      post '/api/v1/validation_codes', params: { email: '919041098@qq.com' }
      expect(response).to have_http_status(429)
    end
    it "邮件不合法就返回 422" do
      post '/api/v1/validation_codes', params: { email: 'x' }
      expect(response).to have_http_status 422
      json = JSON.parse response.body
      expect(json['errors']['email'][0]).to eq "邮件格式不正确"
    end
  end
end
