namespace :dev  do
  task fake_users: :environment do
    User.destroy_all
    user = User.new(
        email: "test@test.com",
        password: "123456",
        name: FFaker::Name::first_name,
        intro: FFaker::Lorem::sentence(30),
        company: FFaker::Company::name,
        job_title: FFaker::Job::title,
        website: "test.website.com",
        twitter: "test.twitter",
        github: "test.github"
      )
    user.save!
    15.times do |i|     
      user = User.new(
        email: FFaker::Name::first_name + "@example.com",
        password: "123456",
        name: FFaker::Name::first_name,
        intro: FFaker::Lorem::sentence(30),
        company: FFaker::Company::name,
        job_title: FFaker::Job::title,
        website: "test" + i.to_s + ".website.com",
        twitter: "test" + i.to_s + ".twitter",
        github: "test" + i.to_s + ".github"
      )
      user.save!
      puts user.email
    end
  end
  
  task fake_questions: :environment do
    Question.destroy_all
      20.times do |i|
        Question.create!(
          title: FFaker::Lorem::phrase,
          content: FFaker::Lorem::paragraphs,
          user_id: User.all.sample.id
          )
      end 
      puts "Now you have #{Question.count} fake questions" 
  end
  
  task fake_solutions: :environment do
    Solution.destroy_all
      30.times do |i|
        Solution.create!(
          content: FFaker::Lorem::paragraphs,
          user_id: User.all.sample.id,
          question_id: Question.all.sample.id,
          )
      end 
      puts "Now you have #{Solution.count} fake Solutions" 
  end
  
  task fake_favorites: :environment do
    # 假資料做在這裡
  end

  task rebuild: [
    "db:drop",
    "db:create",
    "db:migrate",
    "db:seed",
    :fake_users,
    :fake_questions,
    :fake_solutions,
    :fake_favorites
    ]

end