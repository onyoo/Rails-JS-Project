require 'rails_helper'

RSpec.describe Subject, type: :model do

  context 'attributes' do

    it 'has a name, category_id, and user_id' do
      expect(Subject.create(name: "한국어", category_id: 1, user_id: 5)).to be_valid
    end

  end


  context 'validations' do 

    it 'has a unique name' do
      Subject.new(name: "한국어", category_id: 1, user_id: 1)
    end

    it 'is invalid without a name' do
      try_1 = Subject.new(name: nil, category_id: 1, user_id: 1)
      try_2 = Subject.new(name: "", category_id: 1, user_id: 1)
      try_3 = Subject.new(name: " ", category_id: 1, user_id: 1)

      expect(try_1).to have(1).errors_on(:name)
      expect(try_2).to have(1).errors_on(:name)
      expect(try_3).to have(1).errors_on(:name)

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

    it 'belongs to a user' do
      expect(@subject_1.user.first_name).to eq("Scabbers")
    end

    it 'has many resources' do
      expect(@subject_1.resources.count).to eq(2)
    end

    it 'belongs to a category' do
      expect(@subject_1.category.name).to eq("Spoken Languages")
    end

  end

end
