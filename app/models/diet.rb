class Diet < ApplicationRecord
  belongs_to :user

  validates :starting_date, presence: true

  validates :ending_date, presence: true

  validates :weight_goal, 
    presence: true, 
    numericality: { only_integer: true, greater_than: 0}

  validates :current_weight, 
    presence: true, 
    numericality: { only_integer: true, greater_than: 0 }
end
