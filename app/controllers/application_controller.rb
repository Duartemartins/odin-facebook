class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :is_friend?

  layout :layout_by_resource

  protected

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

def is_friend?(user)
	current_user.friends.include?(user)
end

  def already_liked?
    Like.where(user_id: current_user.id, post_id:
    params[:post_id]).exists?
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
