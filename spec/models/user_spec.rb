require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do 
    user = User.new(email: "nikh@gmail.com", password: "123456")
    expect(user).to be_valid
  end
  it "is invalid without email" do
    user = User.new(password: "123456")
    expect(user).not_to be_valid
  end
  it "is invalid without password" do
    user = User.new(email: "nikh@gmail.com")
    expect(user).not_to be_valid
  end
end
