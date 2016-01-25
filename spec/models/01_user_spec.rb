require 'rails_helper'

RSpec.describe User, type: :model do
  context 'attributes' do

    it "ensures a user has a first name, last name, email, username, password" do
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")).to be_valid
    end

  end

  context 'name validations' do

    it "is invalid with no first name, first name that is one letter" do
      try_1 = User.new(first_name: nil, last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")
      try_2 = User.new(first_name: "", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")
      try_3 = User.new(first_name: " ", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")

      expect(try_1).to have(1).errors_on(:first_name)
      expect(try_2).to have(1).errors_on(:first_name)
      expect(try_3).to have(1).errors_on(:first_name)

    end

    it "is invalid with no last name" do
      try_1 = User.new(first_name: "Scabbers", last_name: nil, email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")
      try_2 = User.new(first_name: "Scabbers", last_name: "", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")
      try_3 = User.new(first_name: "Scabbers", last_name: " ", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")
    
      expect(try_1).to have(1).errors_on(:last_name)
      expect(try_2).to have(1).errors_on(:last_name)
      expect(try_3).to have(1).errors_on(:last_name)
    end
  end

  context 'email validations' do

    it "ensures a user has a valid email" do
      try_1 = User.new(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbersgmail.com", username: "Scabbers", password: "supersecure")
      try_2 = User.new(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmailcom", username: "Scabbers", password: "supersecure")
      try_3 = User.new(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.", username: "Scabbers", password: "supersecure")
      try_4 = User.new(first_name: "Scabbers", last_name: "McScabbers", email: "@yo.com", username: "Scabbers", password: "supersecure")
      try_5 = User.new(first_name: "Scabbers", last_name: "McScabbers", email: "Hi@.c", username: "Scabbers", password: "supersecure")
    
      expect(try_1).to have(1).errors_on(:email)
      expect(try_2).to have(1).errors_on(:email)
      expect(try_3).to have(1).errors_on(:email)
      expect(try_4).to have(1).errors_on(:email)
      expect(try_5).to have(1).errors_on(:email)
    end

    it "is invalid if email already exists" do
      User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")
      
      try_1 = User.new(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")
      
      expect(try_1).to have(1).errors_on(:email)
    end
  end

  context 'username validations' do

    it "is invalid with no username" do
      expect(User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: nil, password: "supersecure")).to_not be_valid
    end
  end

  context 'password validations' do

    it "has a password that is 8-72 characters long" do
      try_1 = User.new(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "hi")
      try_2 = User.new(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: nil)

      expect(try_1).to have(1).errors_on(:password)
      expect(try_2).to have(1).errors_on(:password)

    end

  end

  context 'User associations' do

    before do
      @user_1 = User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")
      @user_2 = User.create(first_name: "Srebbacs", last_name: "SrebbacsMc", email: "SrebbacsMc@gmail.com", username: "Srebbacs", password: "supersecure?")

      @category_1 = Category.create(name: "Spoken Languages")
      @category_2 = Category.create(name: "Computer Languages")

      @subject_1 = Subject.create(name: "한국어", category_id: @category_1.id, user_id: @user_1.id)
      @subject_2 = Subject.create(name: "Español", category_id: @category_1.id, user_id: @user_1.id)
      @subject_3 = Subject.create(name: "Ruby", category_id: @category_2.id, user_id: @user_2.id)

      @resource_1 = Resource.create(name: "TTMIK", url: "ttmik.com", description: "Grammar lessons, and sample dialogues.", subject_id: @subject_1.id, user_id: @user_1.id)
      @resource_2 = Resource.create(name: "Naver Dictionary", url: "dic.naver.com", description: "Dictionary.", subject_id: @subject_1.id, user_id: @user_1.id)
      @resource_2 = Resource.create(name: "Learn", url: "learn.co", description: "Learn efficiently and thoroughly.", subject_id: @subject_3.id, user_id: @user_1.id)
      @resource_2 = Resource.create(name: "Code Academy", url: "https://www.codeacademy.com/learn/ruby", description: "Good resource.", subject_id: @subject_3.id, user_id: @user_2.id)
    end

    it 'has many subjects' do
      expect(@user_1.subjects.count).to eq(2)
    end

    it 'has many resources' do
      expect(@user_1.resources.count).to eq(3)
    end

    it 'has many categories' do
      expect(@user_1.categories.uniq.count).to eq(1)
    end

  end

end
