class CreateDiets < ActiveRecord::Migration[5.1]
  def change
    create_table :diets, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.date :starting_date, null: false
      t.date :ending_date, null: false
      t.integer :weight_goal, null: false
      t.integer :current_weight, null: false
      t.timestamps
    end

    add_index(:diets, :user_id)
  end
end
