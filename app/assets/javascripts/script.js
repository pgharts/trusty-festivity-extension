jQuery(document).ready(function($) {


  /* Logic to toggle the top menu icon and
  /* mobile navigation menu */

  $('.mobile-menu-button').click(function(e) {
    $('.menu-icon').toggleClass('menu-icon-active');
    $('.mobile-navigation').toggleClass('active');
  });

  /* implementation of the read more plugin */

  $('.event-long-description').readmore({
    speed: 75,
    // TODO: make sure this isn't covering things up, but a good enough implementation for now
    maxHeight: 184,
    heightMargin: 36
  });


});
