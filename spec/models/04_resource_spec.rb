require 'rails_helper'

RSpec.describe Resource, type: :model do

  context 'attributes' do

    it 'has a name, url, description, topic_id, user_id' do
      expect(Resource.create(name: "TTMIK", url: "ttmik.com", description: "Grammar lessons, and sample dialogues.", subject_id: 1, user_id: 1)).to be_valid
    end

  end

  context 'validations' do 

    it 'is invalid without a name or url' do
      try_1 = Resource.new(name: "", url: "", description: "Grammar lessons, and sample dialogues.", subject_id: 1, user_id: 1)

      expect(try_1).to have(1).errors_on(:name)
      expect(try_1).to have(1).errors_on(:url)
    end

    it 'has a unique name and url' do
      Resource.create(name: "TTMIK", url: "ttmik.com", description: "Grammar lessons, and sample dialogues.", subject_id: 1, user_id: 1)
      try_1 = Resource.new(name: "TTMIK", url: "ttmik.com", description: "Grammar lessons, and sample dialogues.", subject_id: 1, user_id: 1)

      expect(try_1).to have(1).error_on(:name)
      expect(try_1).to have(1).error_on(:url)
    end

  end

  context 'Category associations' do

    before do

      @user_1 = User.create(first_name: "Scabbers", last_name: "McScabbers", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")

      @category_1 = Category.create(name: "Spoken Languages")

      @subject_1 = Subject.create(name: "한국어", category_id: @category_1.id, user_id: @user_1.id)

      @resource_1 = Resource.create(name: "TTMIK", url: "ttmik.com", description: "Grammar lessons, and sample dialogues.", subject_id: @subject_1.id, user_id: @user_1.id)

    end

    it 'has a user' do
      expect(@resource_1.user.first_name).to eq("Scabbers")
    end

    it 'has a subject' do
      expect(@resource_1.subject.name).to eq("한국어")
    end

    it 'has a category ' do
      expect(@resource_1.category.name).to eq("Spoken Languages")
    end

  end

end
