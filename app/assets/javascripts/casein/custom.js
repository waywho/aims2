// CASEIN CUSTOM
// Use this file for your project-specific Casein JavaScript
$(document).ready(function() {
	$(document).on('page:load', function(){
		window['rangy'].initialized = false
	});
	$('.description-box').each(function(i, elem) {
	      $(elem).wysihtml5();
	 });
})
