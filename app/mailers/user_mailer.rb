class UserMailer < ApplicationMailer
  def welcome_email(code)
    @code = code
    mail(to: "919041098@qq.com", subject: 'hi')
  end
end
