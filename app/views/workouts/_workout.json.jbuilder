json.extract! workout, :id, :title, :description, :start_time, :end_time, :user_id, :created_at, :updated_at
json.url workout_url(workout, format: :json)
