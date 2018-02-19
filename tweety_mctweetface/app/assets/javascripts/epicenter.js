// Watch the DOM(document) and whenever turbolinks loads a new view have the following function ready
$(document).on('turbolinks:load', function() {
	// when the btn w id=unfollow_btn is hovered over, do these two things depending on it's current state
	// .hover takes two arguments; a handlerIn and a handlerOut
	$('#unfollow_btn').hover(function() {
		//selects the current HTML element...here it is easier than '#unfollow_btn'
		$(this).removeClass('btn-primary');
		$(this).addClass('btn-danger');
		$(this).html("Unfollow");
	}, function() {
		$(this).html("Following");
		$(this).removeClass('btn-danger');
		$(this).addClass('btn-primary');
	});
})