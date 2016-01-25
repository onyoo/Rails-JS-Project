require 'rails_helper'

RSpec.describe User, type: :model do
  context 'attributes and validations' do

### NAMEs

    it "ensures a user has a first name" do
      expect(User.create(first_name: "Scabbers")).to be_valid
    end

    it "is invalid with no first name, first name that is one letter" do
      expect(User.create(first_name: nil)).to_not be_valid
      expect(User.create(first_name: "")).to_not be_valid
      expect(User.create(first_name: " ")).to_not be_valid
    end

    it "ensures a user has a last name" do
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers")).to be_valid
    end

    it "is invalid with no last name" do
      expect(User.create(first_name: "Scabbers", last_name: nil)).to_not be_valid
    end

### EMAIL

    it "ensures a user has an email" do
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com")).to be_valid
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@learn.co")).to be_valid
    end

    it "is invalid with no email" do
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: nil)).to_not be_valid
    end

    it "ensures a user has a valid email" do
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbersgmail.com")).to_not be_valid
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmailcom")).to_not be_valid
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.")).to_not be_valid
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "@yo.com")).to_not be_valid
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "Hi@.c")).to_not be_valid
    end

    it "is invalid if email already exists" do
      User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com")
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com")).to_not be_valid
    end

### USERNAME

    it "ensures a user has a username" do
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers")).to be_valid
    end

    it "is invalid with no username" do
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: nil)).to_not be_valid
    end

### PASSWORD
    it "has a password that is 6+ characters long" do
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")).to be_valid
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "hi")).to_not be_valid
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: nil)).to be_valid
    end

  end

  context 'User associations' do

    before do
      User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers")
    end

    it 'has many posts' do
      expect(@crookshanks.posts.count).to eq(2)
    end
  end

end
