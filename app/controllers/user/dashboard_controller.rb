class User::DashboardController < ApplicationController
  before_action :authenticate_user!

  layout 'app'
  def index
    @user = current_user
  end
end
