Factory.define :hacker do |hacker|
  hacker.email                  "dom@hodgetastic.com"
  hacker.password               "foobar"
  hacker.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :team do |team|
  team.name         "TeamName"
  team.description  "Team description here"
end

Factory.define :category do |category|
  category.name     "Category 1"
end

Factory.define :submission do |submission|
  submission.name         "This is a hack name"
  submission.description  "This is a description of a hack"
  submission.url          "www.example.com"
  submission.category_ids [1]
  submission.association  :team
end
