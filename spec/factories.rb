Factory.define :user do |user|
  user.name                  "Ken Kittlitz"
  user.email                 "kittlitz@gmail.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content          "foo bar"
  micropost.association      :user
end
