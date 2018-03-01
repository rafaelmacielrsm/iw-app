class User::DashboardController < ApplicationController
  layout 'app'

  before_action :authenticate_user!

  def index
    @user = current_user

    @diets = 
      @user
      .diets
      .includes(:diet_progress)
      .order(created_at: :desc)
      .page params[:page]

    @current_diet = @diets.first

    @date_progress = DietProgress.new

    unless @current_diet.nil?
      @chart_data = {
        weight_data: @current_diet.diet_progress.map{|e| e.weight / 1000.0},
        goal: @current_diet.weight_goal / 1000.0,
        date_array: @current_diet.diet_progress.map{|e| 
          e.weighing_date.strftime("%d/%m/%y") }
      }
    end
    
  end
end
