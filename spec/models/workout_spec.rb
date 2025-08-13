require 'rails_helper'

RSpec.describe Workout, type: :model do
  let(:user) { User.create!(email: "nikhil@gmail.com", password: "123456") }
  it "is valid with valid attributes" do
    workout = Workout.new(title: "Running", description: "Jogging", start_time: Time.current + 1.hour, end_time: Time.current + 2.hours, user: user)
    expect(workout).to be_valid
  end
  it "is invalid without title" do
    workout = Workout.new(description: "Jogging", start_time: Time.current + 1.hour, end_time: Time.current + 2.hours, user: user)
    expect(workout).not_to be_valid
  end
  it "is invalid without title" do
    workout = Workout.new(title: "Running", start_time: Time.current + 1.hour, end_time: Time.current + 2.hours, user: user)
    expect(workout).not_to be_valid
  end
  it "is invalid if start_time before end_time" do
    workout = Workout.new(title: "Running", description: "Jogging", start_time: Time.current + 2.hours, end_time: Time.current + 1.hour, user: user)
    expect(workout).not_to be_valid
  end
end
