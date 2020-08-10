# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController

  def create
    @user = params[:user]
    super
    if @user.persisted?
      UserMailer.welcome_email(@user).deliver_now
    end
  end
end
