# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@user_1 = User.create(first_name: "Test", last_name: "McTesty", email: "McScabbers@gmail.com", username: "Scabbers", password: "supersecure")
@user_2 = User.create(first_name: "Srebbacs", last_name: "SrebbacsMc", email: "SrebbacsMc@gmail.com", username: "Srebbacs", password: "supersecure?")


@category_1 = Category.create(name: "Spoken Languages")
@category_2 = Category.create(name: "Computer Languages")

@subject_1 = Subject.create(name: "한국어", category_id: @category_1.id, user_id: @user_1.id)
@subject_2 = Subject.create(name: "Español", category_id: @category_1.id, user_id: @user_2.id)


@resource_1 = Resource.create(name: "TTMIK", url: "www.ttmik.com", description: "Grammar lessons, and sample dialogues.", subject_id: @subject_1.id, user_id: @user_1.id)
@resource_2 = Resource.create(name: "Naver Dictionary", url: "dic.naver.com", description: "Dictionary.", subject_id: @subject_1.id, user_id: @user_1.id)
@resource_3 = Resource.create(name: "NIS", url: "www.notesinspanish.com", description: "Listen to Ben and Marina.", subject_id: @subject_2.id, user_id: @user_2.id)
