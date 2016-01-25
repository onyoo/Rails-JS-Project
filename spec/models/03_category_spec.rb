require 'rails_helper'

RSpec.describe Category, type: :model do

  context 'attributes' do

    it 'has a name' do
      expect(Category.create(name: "Spoken Languages")).to be_valid
    end

  end

  context 'validations' do 

    it 'has a unique name' do
      Category.create(name: "Spoken Languages")
      try_1 = Category.new(name: "Spoken Languages")

      expect(try_1).to have(1).error_on(:name)
    end

    it 'is invalid without a name' do

      expect(Category.create(name: "")).to have(1).errors_on(:name)
      expect(Category.create(name: " ")).to have(1).errors_on(:name)

    end

  end

  context 'Category associations' do

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
      @resource_3 = Resource.create(name: "Learn", url: "learn.co", description: "Learn efficiently and thoroughly.", subject_id: @subject_3.id, user_id: @user_1.id)
      @resource_4 = Resource.create(name: "Code Academy", url: "https://www.codeacademy.com/learn/ruby", description: "Good resource.", subject_id: @subject_3.id, user_id: @user_2.id)
      @resource_4 = Resource.create(name: "NIS", url: "https://www.notesinspanish.com", description: "Listen to Ben and Marina.", subject_id: @subject_2.id, user_id: @user_2.id)
    end

    it 'has many users' do
      expect(@category_1.users.count).to eq(2)
    end

    it 'has many subjects' do
      expect(@category_1.subjects.count).to eq(2)
    end

    it 'has many resources' do
      expect(@category_1.resources.count).to eq(3)
    end

  end

end
