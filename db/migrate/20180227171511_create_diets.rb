class CreateDiets < ActiveRecord::Migration[5.1]
  def change
    create_table :diets, id: :uuid do |t|
      t.uuid :user_id
      t.date :starting_date
      t.date :ending_date
      t.integer :weight_goal
      t.integer :current_weight
      t.timestamps
    end
  end
end
