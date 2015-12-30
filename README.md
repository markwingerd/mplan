# About
Meal Planner is a rails based website which will provide several features for users.  You can create recipes other users can search for and you can add recipes to a meal plan which will create a grocery list you can print.  More features will be added.

# Setup
- `bundle install`
- `cp config/secrets.yml.dist config/secrets.yml`
- Use `rake secret` to generate a secret_key_base for development and test in the new secrets.yml file. (Manually add the output in the file)
- `rake db:create db:migrate db:seed`
- `rails server`

# Helpful Docs
- guides.rubyonrails.org/getting_started.html
- http://pcottle.github.io/learnGitBranching/
- http://guides.railsgirls.com/github/
- https://guides.github.com/introduction/flow/index.html
- https://gist.github.com/hofmannsven/6814451