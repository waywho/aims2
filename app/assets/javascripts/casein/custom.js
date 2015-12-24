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

	Dropzone.options.myAwesomeDropzone = {
	init: function() {
		this.on("thumbnail", function (file) {
			$(".dz-image img").addClass("img-responsive");
		});
	},
	paramName: 'photo[image]',
	uploadMultiple: false,
	clickable: true,
	acceptedFiles: 'image/*',
	thumbnailWidth: '160',
	thumbnailHeight: '160'
	};


	$('.sub-btn').prop('disabled', true);
	$(".container .cbox").hide();
	$('.image-select').click(function() {
		var $checkbox = $(this).parent().find('.cbox');
		$(this).toggleClass('selected');
		$checkbox.prop('checked', !$checkbox.prop('checked'));
		$('.sub-btn').prop('disabled', !$('.cbox:checked').length);
	});
	$('.cbox').on('change', function () {
		$('.sub-btn').prop('disabled', !$('.cbox:checked').length);
	}).change();

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
