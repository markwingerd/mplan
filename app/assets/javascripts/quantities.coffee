# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	# Add autocomplete to text fields that exist
	$("[id^=user_quantities_attributes]").autocomplete
		source: $("#user_quantities_attributes_0_ingredient_name").data('autocomplete-source')
		minLength: 2

	# Add autocomplete to text fields that are created w/ cocoon
	$('#recipe-ingredients')
		.on('cocoon:after-insert', (e, task_to_be_added) ->
			$("[id^=user_quantities_attributes]").autocomplete
				source: $("#user_quantities_attributes_0_ingredient_name").data('autocomplete-source')
				minLength: 2
		)