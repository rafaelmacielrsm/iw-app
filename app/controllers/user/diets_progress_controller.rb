class User::DietsProgressController < ApplicationController
  before_action :authenticate_user!
  
  def create
    respond_to do |format|
      format.js {
        @diet = current_user
          .diets
          .find(params["diet_id"])

        params_hash = diet_progress_params

        @diet_progress = DietProgress.
          where({ 
            weighing_date: params_hash["weighing_date"], 
            diet_id: @diet.id })
          .first_or_initialize
        
        @diet_progress.assign_attributes( params_hash )  

        if @diet_progress.valid?
          @diet_progress.save
          @weight_data = @diet.diet_progress.map{|e| e.weight / 1000.0}
          @date_array = @diet.diet_progress.map{|e| 
            e.weighing_date.strftime("%d/%m/%y") }

          render file: 'shared/on_date_progress_success'
        else 
            render file: 'shared/on_date_progress_failure'
        end 
      }
    end
  end

  private
  
  def diet_progress_params
    params_hash = params.require(:diet_progress).
      permit([:weighing_date, :weight])

    params_hash["weight"].gsub!(/\D/, '')

    params_hash
  end
end
