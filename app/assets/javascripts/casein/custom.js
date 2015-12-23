// CASEIN CUSTOM
// Use this file for your project-specific Casein JavaScript

	function buttonChange () {
		var state = $('#current-state').text();
		console.log(state);

		if (state == 'draft') {
			$('.draft').show();
			$('.submit').show();
			$('.approve').hide();
			$('.reject').hide();
			$('.publish').show();
			$('.update').hide();
		} else if (state == 'pending_review') {
			$('.draft').hide();
			$('.submit').hide();
			$('.approve').show();
			$('.reject').hide();
			$('.publish').show();
			$('.update').hide();
		} else if (state == 'approved') {
			$('.draft').hide();
			$('.submit').hide();
			$('.approve').hide();
			$('.reject').show();
			$('.publish').show();
			$('.update').hide();
		} else {
			$('.draft').hide();
			$('.submit').hide();
			$('.approve').hide();
			$('.reject').hide();
			$('.publish').hide();
			$('.update').show();
		}
	};


$(document).ready(function() {
	$(document).on('page:load', function(){
		window['rangy'].initialized = false
	});

	$('.description-box').each(function(i, elem) {
	      $(elem).wysihtml5();
	 });

	$('#stateform').hide();
	$('#edit-state').click(function() {
		event.preventDefault();
		$('#state-status').hide();
		$('#stateform').show();
	});
	$('#course_workflow_state').change(function() {
		$('#stateform').submit();
	});

	buttonChange();

		
})
