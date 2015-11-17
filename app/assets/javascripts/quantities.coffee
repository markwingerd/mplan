# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	# Add autocomplete to text fields that exist
	$(".ingredient_autocomplete").autocomplete
		source: '/ingredients/autocomplete.json'
		minLength: 2

	# Add autocomplete to text fields that are created w/ cocoon
	$('#recipe-ingredients')
		.on('cocoon:after-insert', (e, added_task) ->
			console.log('blarg');
			$(".ingredient_autocomplete").autocomplete
				source: '/ingredients/autocomplete.json'
				minLength: 2
		)