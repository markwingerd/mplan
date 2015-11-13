# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	# AutoComplete feature for Users.
	# Add autocomplete to text fields that exist
	$("[id^=user_quantities_attributes]").autocomplete
		source: '/ingredients/autocomplete.json'
		minLength: 2

	# Add autocomplete to text fields that are created w/ cocoon
	$('#recipe-ingredients')
		.on('cocoon:after-insert', (e, task_to_be_added) ->
			$("[id^=user_quantities_attributes]").autocomplete
				source: '/ingredients/autocomplete.json'
				minLength: 2
		)

	# AutoComplete feature for Recipes.
	# Add autocomplete to text fields that exist
	$("[id^=recipe_quantities_attributes]").autocomplete
		source: '/ingredients/autocomplete.json'
		minLength: 2

	# Add autocomplete to text fields that are created w/ cocoon
	$('#recipe-ingredients')
		.on('cocoon:after-insert', (e, task_to_be_added) ->
			$("[id^=recipe_quantities_attributes]").autocomplete
				source: '/ingredients/autocomplete.json'
				minLength: 2
		)