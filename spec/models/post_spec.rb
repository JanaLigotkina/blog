require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(nickname: "john_doe", email: "john@example.com", password: "password") }

  it "is valid with valid attributes" do
    post = user.posts.new(title: "Test Post", body: "Example body text")
    expect(post).to be_valid
  end

  it "is not valid without a title" do
    post = user.posts.new(body: "Example body text")
    expect(post).not_to be_valid
  end

  it "is not valid without a body" do
    post = user.posts.new(title: "Test Post")
    expect(post).not_to be_valid
  end

  it "is not valid with a title less than 5 characters" do
    post = user.posts.new(title: "Test", body: "Example body text")
    expect(post).not_to be_valid
  end

  it "belongs to a user" do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq(:belongs_to)
  end

  it "has many comments" do
    association = described_class.reflect_on_association(:comments)
    expect(association.macro).to eq(:has_many)
  end

  it "destroys associated comments when destroyed" do
    post = user.posts.create(title: "Test Post", body: "Example body text")
    post.comments.create(user: user, body: "Great post!")

    expect { post.destroy }.to change { Comment.count }.by(-1)
  end
end
