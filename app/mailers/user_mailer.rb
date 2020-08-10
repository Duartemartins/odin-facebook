# frozen_string_literal: true

class UserMailer < Devise::Mailer
  default from: 'admin@salushub.club'

  def welcome_email(user)
    @user = user
    @email = user.email
    @name = user.first_name
    @url  = 'http://www.salushub.club'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

  def reset_password_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :reset_password_instructions, opts)
  end
end
