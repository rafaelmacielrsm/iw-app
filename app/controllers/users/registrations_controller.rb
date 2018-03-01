# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  layout 'app'
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::JavaScriptHelper

  def create
    @user = User.new(user_params)

    if @user.valid? 
      @user.save
      sign_in @user
      flash[ :notice ] = I18n.t 'devise.registrations.signed_up'
      redirect_to user_profile_path 
    else
      flash[ :alert ] = I18n.t 'errors.messages.not_saved.one', resource: User
      render 'new'
    end
  end

  protected
  def user_params
    params_hash = params.require(:user).permit([:name, :email, :password, :height])
    sanitize_inputs params_hash
  end

  def sanitize_inputs(params)
    fields = ['name', 'email'].freeze

    fields.each do |field|
      params[field] = escape_javascript( sanitize params[field] )
    end
    
    return params
  end
end
