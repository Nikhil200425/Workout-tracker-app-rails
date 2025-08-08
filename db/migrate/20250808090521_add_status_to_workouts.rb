class AddStatusToWorkouts < ActiveRecord::Migration[8.0]
  def change
    add_column :workouts, :status, :string
  end
end
