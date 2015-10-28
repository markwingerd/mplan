# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: "Chicago" }, { name: "Copenhagen" }])
#   Mayor.create(name: "Emanuel", city: cities.first)
User.create(:email => "asdf@asdf.com", :password => "asdfasdf", :password_confirmation => "asdfasdf")
Property.create([{ :ingredient_id => 1, :vegan => false },	#1
				 { :ingredient_id => 2, :vegan => true },	#2
				 { :ingredient_id => 3, :vegan => true },	#3
				 { :ingredient_id => 4, :vegan => true, :glutenFree => false },	#4
				 { :ingredient_id => 5, :vegan => true },	#5
				 { :ingredient_id => 6, :vegan => true },	#6
				 { :ingredient_id => 7, :vegan => true },	#7
				 { :ingredient_id => 8, :vegan => true },	#8
				 { :ingredient_id => 9, :vegan => true },	#9
				 { :ingredient_id => 10, :vegan => true, :glutenFree => false },	#10
				 { :ingredient_id => 11, :vegitarian => true, :glutenFree => false },	#11
				 { :ingredient_id => 12, :vegitarian => true, :lactoseFree => false }, #12
				 { :ingredient_id => 13, :vegan => true },	#13
				 { :recipe_id => 1, :vegan => false },	#14
				 { :recipe_id => 2, :vegan => false },	#15
				 { :recipe_id => 3, :lactoseFree => false, :glutenFree => false } #16
				])
Ingredient.create([{ name: "Chicken" }, #1
				   { name: "Salt", buyInWholeUnits: false }, #2
				   { name: "Pepper", buyInWholeUnits: false }, #3
				   { name: "Whole-wheat seaseme buns" }, #4
				   { name: "Red Onion" }, #5
				   { name: "Red Peppers" }, #6
				   { name: "Chimichurri", buyInWholeUnits: false }, #7
				   { name: "Lemon" }, #8
				   { name: "Olive Oil", buyInWholeUnits: false }, #9
				   { name: "Pizza Crust" }, #10
				   { name: "Barbeque Sauce", buyInWholeUnits: false }, #11
				   { name: "Smoked Gouda" }, #12
				   { name: "Jalapeno Pepper"} #13
				  ])
Quantity.create(:user_id => 1, :amount => 1, :ingredient_id => 1)
Quantity.create(:user_id => 1, :amount => 4, :ingredient_id => 2)
Quantity.create(:user_id => 1, :amount => 4, :ingredient_id => 3)
Quantity.create(:user_id => 1, :amount => 2, :ingredient_id => 5)
Quantity.create(:user_id => 1, :amount => 1, :ingredient_id => 9)
Recipe.create(:title => "Grilled Chicken Sandwich", :description => "Sandwich with chimichurri and grilled chicken", :instructions => "Season the chicken all over with salt and pepper. Grill for 3 to 4 minutes per side, until firm and cooked through.\n\nTop each bun with a chicken thigh, then pile on the onion and peppers. Spoon on the chimichurri.")
Quantity.create(:recipe_id => 1, :amount => 4, :ingredient_id => 1)
Quantity.create(:recipe_id => 1, :amount => 1, :ingredient_id => 2)
Quantity.create(:recipe_id => 1, :amount => 1, :ingredient_id => 3)
Quantity.create(:recipe_id => 1, :amount => 0.5, :ingredient_id => 5)
Quantity.create(:recipe_id => 1, :amount => 0.5, :ingredient_id => 6)
Quantity.create(:recipe_id => 1, :amount => 0.5, :ingredient_id => 7)
Recipe.create(:title => "Chicken Under a Brick", :description => "Bricks ontop of chicken", :instructions => "Combine the olive oil, lemon zest and juice, salt, and pepper into a large bowl. Add the chicken and turn to coat. Cover the bowl and marinate in the regriderator for at least 30 minutes and up to 4 hours.\n\nPrehead a grill. Remove the chicken from the marinade and place on the grate. Cover the grill and good for 10 minutes until the chicken is lightly charred. Flip the chicken over, then place a brick on top and cook for another 15 to 20 minutes until the skin is throroughly browned and crisp.\n\nSeperate each breast from the chicken.")
Quantity.create(:recipe_id => 2, :amount => 0.25, :ingredient_id => 9)
Quantity.create(:recipe_id => 2, :amount => 2, :ingredient_id => 8)
Quantity.create(:recipe_id => 2, :amount => 1, :ingredient_id => 2)
Quantity.create(:recipe_id => 2, :amount => 0.5, :ingredient_id => 3)
Quantity.create(:recipe_id => 2, :amount => 1, :ingredient_id => 1)
Recipe.create(:title => "Barbecue Chicken Pizza", :description => "Pizza with barbeque", :instructions => "Preheat oven to 500f. Place Pizza stone in the oven.\n\nSpread crust with a thin layer of BBQ sauce, then devide the gouda, onion, jalapeno, and chicken between the two.\n\nCook until the crust is golden and the cheese is fully melted.")
Quantity.create(:recipe_id => 3, :amount => 1, :ingredient_id => 10)
Quantity.create(:recipe_id => 3, :amount => 0.75, :ingredient_id => 11)
Quantity.create(:recipe_id => 3, :amount => 1.5, :ingredient_id => 12)
Quantity.create(:recipe_id => 3, :amount => 0.5, :ingredient_id => 5)
Quantity.create(:recipe_id => 3, :amount => 0.5, :ingredient_id => 13)
Quantity.create(:recipe_id => 3, :amount => 1, :ingredient_id => 1)
