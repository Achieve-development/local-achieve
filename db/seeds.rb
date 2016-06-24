20.times do |n|
  User.create(
    user_name: "Test Diver#{n}",
    nick_name: "Test Diver#{n}",
    email: "diveintocode#{n}@example.com",
    password: 'iwillbeanengineer’,
    uid: “#{n}”)
end
