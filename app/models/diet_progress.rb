class DietProgress < ApplicationRecord
  belongs_to :diet

  validates :weight, presence: true, numericality: { only_integer: true }
  validates :weighing_date_before_type_cast, date: true
end
