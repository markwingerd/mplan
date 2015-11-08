# About
Meal Planner is a rails based website which will provide several features for users.  You can create recipes other users can search for and you can add recipes to a meal plan which will create a grocery list you can print.  More features will be added.

# Setup
- `bundle install`
- `rake db:create db:migrate db:seed`
- `rails server`
- `rake sunspot:solr:start`
- `rake sunspot:solr:reindex` note: this may need to be done in another console window.

# Helpful Docs
- guides.rubyonrails.org/getting_started.html
- http://pcottle.github.io/learnGitBranching/
- http://guides.railsgirls.com/github/
- https://guides.github.com/introduction/flow/index.html