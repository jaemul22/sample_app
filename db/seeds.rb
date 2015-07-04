
99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	User.create!(name: name,
			email: email,
			password: "foobar",
			password_confirmation: "foobar")
end