class CreateDietsProgress < ActiveRecord::Migration[5.1]
  def change
    create_table :diets_progress do |t|
      t.uuid :diet_id
      t.date :weighing_date
      t.integer :weight
      t.timestamps
    end

    add_index(:diets_progress, :diet_id)
  end
end
