require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = User.new(nickname: "john_doe", email: "john@example.com", password: "password")
    expect(user).to be_valid
  end

  it "is not valid without a nickname" do
    user = User.new(email: "john@example.com", password: "password")
    expect(user).not_to be_valid
  end

  it "is not valid without an email" do
    user = User.new(nickname: "john_doe", password: "password")
    expect(user).not_to be_valid
  end

  it "is not valid without a password" do
    user = User.new(nickname: "john_doe", email: "john@example.com")
    expect(user).not_to be_valid
  end

  it "is not valid with a duplicate nickname" do
    User.create(nickname: "john_doe", email: "john@example.com", password: "password")
    user = User.new(nickname: "john_doe", email: "another@example.com", password: "password")
    expect(user).not_to be_valid
  end

  it "is not valid with a duplicate email" do
    User.create(nickname: "john_doe", email: "john@example.com", password: "password")
    user = User.new(nickname: "another_doe", email: "john@example.com", password: "password")
    expect(user).not_to be_valid
  end

  it "is not valid with an invalid email format" do
    user = User.new(nickname: "john_doe", email: "invalid_email", password: "password")
    expect(user).not_to be_valid
  end

  it "downcases the nickname before saving" do
    user = User.create(nickname: "JohnDoe", email: "john@example.com", password: "password")
    expect(user.nickname).to eq("johndoe")
  end
end
