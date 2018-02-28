class User::DietsController < ApplicationController
  layout 'app'
  
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::JavaScriptHelper
  
  before_action :authenticate_user!
  before_action :set_user, only: [:new]

  def show

  end

  def new
    @diet = Diet.new
  end

  def create    
    @diet = Diet.new(diet_params)
    @diet.user = current_user

    if @diet.valid?
      @diet.save

      flash[:notice] = "Diet created successfully"

      redirect_to user_profile_path, stataus: :created
    else
      flash[:alert] = "Diet could not be created"
      render 'new'
    end
  end

  private
  def diet_params
    params_hash = params.require(:diet).
      permit([:ending_date, :weight_goal, :current_weight])

    params_hash["starting_date"] = Date.today
    
    ["weight_goal", "current_weight"].each do |e|
      params_hash[e].gsub!(/\D/, '')
    end

    params_hash
  end

  def set_user
    @user = current_user
  end
end

