class User::DashboardController < ApplicationController
  before_action :authenticate_user!

  layout 'app'
  def index
    @user = current_user
    @diets = @user.diets.order(created_at: :desc).page params[:page]
    @current_diet = @diets.first
  end
end
