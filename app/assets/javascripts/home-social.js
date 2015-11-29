$(document).ready(function() {
	imagesLoaded('.home.first-night', function() {
		$('.social-posts').masonry({
			itemSelector: '.social-posts article',
			"gutter": '.grid-sizer',
			percentPosition: true
		});
	});
});
