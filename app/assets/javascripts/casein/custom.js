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
			$('.unpublish').hide();
			$('.update').hide();
		} else if (state == 'pending_review') {
			$('.draft').hide();
			$('.submit').hide();
			$('.approve').show();
			$('.reject').show();
			$('.publish').show();
			$('.unpublish').hide();
			$('.update').hide();
		} else if (state == 'approved') {
			$('.draft').hide();
			$('.submit').hide();
			$('.approve').hide();
			$('.reject').hide();
			$('.publish').show();
			$('.unpublish').hide();
			$('.update').hide();
		} else {
			$('.draft').hide();
			$('.submit').hide();
			$('.approve').hide();
			$('.reject').hide();
			$('.publish').hide();
			$('.unpublish').show();
			$('.update').show();
		}
	}


$(document).ready(function() {
	$(document).on('page:load', function(){
		window['rangy'].initialized = false
	});

	$('.description-box').each(function(i, elem) {
	      $(elem).wysihtml5({
	      	toolbar: {
	      		"html": true,
	      		"color": true
	      	}

	      });
	 });

	$('.description-box-small').each(function(i, elem) {
	      $(elem).wysihtml5({
	      	toolbar: {
	      		"font-style": false,
	      		"lists": false,
	      		"html": true,
	      		"image": false,
	      		"color": false,
	      		"blockquote": false
	      	}
	      });
	 });

	$('.gallery-btn').click(function() {
		$('.gallery-form').show();
		$('.upload-div').hide();
		$('.no-photo').hide();
	});


	$('.upload-btn').click(function() {
		$('.gallery-form').hide();
		$('.upload-div').show();
		$('.no-photo').hide();
	})


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

	var $currentState = $('#current-state')
	if($currentState.length > 0) {
		buttonChange();
	};

	$('.sub-btn').prop('disabled', true);
	$(".container .cbox").hide();
	$('.image-select').click(function() {
		var $checkbox = $(this).parent().find('.cbox');
		$(this).toggleClass('selected');
		$checkbox.prop('checked', !$checkbox.prop('checked'));
		$('.sub-btn').prop('disabled', !$('.cbox:checked').length);
	});
	$('.cbox').on('change', function() {
		$('.sub-btn').prop('disabled', !$('.cbox:checked').length);
	}).change();

	$('#stateform select').hide();
	$('#edit-state').click(function() {
		event.preventDefault();
		$('#state-status').hide();
		$('.state-icon').remove();
		$('#stateform select').show();
	});
	$('#stateform select').change(function() {
		$('#stateform').submit();
	});
	$('#multi').on('change', function() {
		$('.index-check').prop('checked', !$('.index-check').prop('checked'));
	});

	$('.multi-record').click(function() {
		event.preventDefault();
		var $multicheckboxes = $(this).parent().find('input[type=checkbox]');
		$multicheckboxes.prop('checked', !$multicheckboxes.prop('checked'));
	});

	$('form').on('click', '.remove_fields', function(event) {
		$(this).prev("input[type=hidden]").val("1")
	  	$(this).closest('fieldset').hide()
	  	event.preventDefault();
	});

	$('.add_fields').on('click', function() {
		event.preventDefault();
	  	var time = new Date().getTime();
	  	var regexp = new RegExp($(this).data('id'), "g");
	  	$(this).before($(this).data('fields').replace(regexp, time));
	  	$('#courseformat_highlights_attributes_'+time+"_description").wysihtml5({
	      	toolbar: {
	      		"font-style": false,
	      		"lists": false,
	      		"html": true,
	      		"image": false,
	      		"color": false,
	      		"blockquote": false
	      	}
	      });

	});

		
})
