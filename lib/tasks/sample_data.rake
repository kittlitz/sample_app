require 'faker'

namespace :db do
  desc "fill database with sample data"
  task :populate => :environment do  # Load Rails env
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
      :email => "example@railstutorial.org",
      :password => "foobar",
      :password_confirmation => "foobar")
    # Can't set admin in create! because it's not attr_accessible
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
        :email => email,
        :password => password,
        :password_confirmation => password)
    end
  end
end
