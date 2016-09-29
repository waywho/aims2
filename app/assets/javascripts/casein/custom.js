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
	      $(elem).froalaEditor({
	      	inlineMode: false,
	      	charCounterCount: true,
	      	heightMin: 400,
	      	fileUploadURL: "/casein/documents/insert_file",
	      	fileUploadParam: "document[file]",
	      	linkConvertEmailAddress: true,
	      	imageManagerLoadURL: "/casein/photos.json",
	      	imageUploadURL: '/casein/photos',
	      	imageUploadParam: 'photo[image]',
	      	htmlAllowedTags: ['a', 'abbr', 'address', 'area', 'article', 'aside', 'audio', 'b', 'base', 'bdi', 'bdo', 
	      		'blockquote', 'br', 'button', 'canvas', 'caption', 'cite', 'code', 'col', 'colgroup', 'datalist', 
	      		'dd', 'del', 'details', 'dfn', 'dialog', 'div', 'dl', 'dt', 'em', 'embed', 'fieldset', 'figcaption', 
	      		'figure', 'footer', 'form', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'header', 'hgroup', 'hr', 'i', 'iframe', 
	      		'img', 'input', 'ins', 'kbd', 'keygen', 'label', 'legend', 'li', 'link', 'main', 'map', 'mark', 'menu', 
	      		'menuitem', 'meter', 'nav', 'noscript', 'object', 'ol', 'optgroup', 'option', 'output', 'p', 'param', 
	      		'pre', 'progress', 'queue', 'rp', 'rt', 'ruby', 's', 'samp', 'script', 'style', 'section', 'select', 
	      		'small', 'source', 'span', 'strike', 'strong', 'sub', 'summary', 'sup', 'table', 'tbody', 'td', 'textarea', 
	      		'tfoot', 'th', 'thead', 'time', 'title', 'tr', 'track', 'u', 'ul', 'var', 'video', 'wbr', 'class'],
	      	toolbarButtons: ['fullscreen', 'bold', 'italic', 'underline', 
	      		'strikeThrough','fontSize', '|', 'color', 'paragraphStyle', 
	      		'|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 
	      		'indent', 'quote', 'insertHR', '-', 'insertLink', 'insertImage', 
	      		'insertFile', 'insertTable', 'undo', 'redo', 
	      		'clearFormatting', 'selectAll', 'html']
	      });
	 });

	$('.description-box-small').each(function(i, elem) {
		$(elem).froalaEditor({
	      	inlineMode: false,
	      	charCounterCount: true,
	      	heightMin: 100, 
	      	toolbarButtons: ['bold', 'italic', 'underline', 
	      	'strikeThrough', '|', 'color', 'formatOL', 'formatUL', 'quote', 'insertLink', 'undo', 'redo', 
	      	'clearFormatting', 'selectAll', 'html']
	      });
	 });

	function split( val ) {
      return val.split( /,\s*/ );
    };
    function extractLast( term ) {
      return split( term ).pop();
    };

    $( "#keywords" )
      // don't navigate away from the field on tab when selecting an item
      .bind( "keydown", function( event ) {
        if ( event.keyCode === $.ui.keyCode.TAB &&
            $( this ).autocomplete( "instance" ).menu.active ) {
          event.preventDefault();
        }
      })
      .autocomplete({
        minLength: 0,
        source: function( request, response ) {
          // delegate back to autocomplete, but extract the last term
          response( $.ui.autocomplete.filter(
            $('#keywords').data('autocomplete-source'), extractLast( request.term ) ) );
        },
        focus: function() {
          // prevent value inserted on focus
          return false;
        },
        select: function( event, ui ) {
          var terms = split( this.value );
          // remove the current input
          terms.pop();
          // add the selected item
          terms.push( ui.item.value );
          // add placeholder to get the comma-and-space at the end
          terms.push( "" );
          this.value = terms.join( ", " );
          return false;
        }
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
		thumbnailWidth: '200',
		thumbnailHeight: '200'
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
	  	$('#courseformat_highlights_attributes_'+time+"_description").froalaEditor({
	      	inlineMode: false,
	      	charCounterCount: true,
	      	linkConvertEmailAddress: true,
	      	heightMin: 100, 
	      	toolbarButtons: ['bold', 'italic', 'underline', 
	      	'strikeThrough', '|', 'color', 'formatOL', 'formatUL', 'quote', 'insertLink', 'undo', 'redo', 
	      	'clearFormatting', 'selectAll', 'html']
	      });
	});

		
})
