class Diet < ApplicationRecord
  belongs_to :user
  has_many :diet_progress, lambda { order( :weighing_date )}

  validates :starting_date, presence: true

  validates :ending_date_before_type_cast, date: true

  validates :weight_goal, 
    presence: true, 
    numericality: { only_integer: true, greater_than: 0}

  validates :current_weight, 
    presence: true, 
    numericality: { only_integer: true, greater_than: 0 }

  after_create :save_first_progress

  def save_first_progress
    DietProgress.create({
      diet: self, 
      weight: self.current_weight, 
      weighing_date: self.starting_date
    })
  end
end
