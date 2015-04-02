jQuery(document).ready(function($) {


  /* Logic to toggle the top menu icon and
  /* mobile navigation menu */

  $('.mobile-menu-button').click(function(e) {
    $('.menu-icon').toggleClass('menu-icon-active');
    $('.mobile-navigation').toggleClass('active');
  });


  /* simple function for showing/hiding things in an acco. */

  $("#music").click(function () {
    $("#musicinfo").toggle("slow");
  });

  /* implementation of the read more plugin */

  $('.event-long-description').readmore({
    speed: 75,
    // TODO: make sure this isn't covering things up, but a good enough implementation for now
    maxHeight: 184,
    heightMargin: 36
  });

  // $('.faq-navigation').affix({
  //   offset: {
  //     top: 200,
  //     bottom: function () {
  //       return (this.bottom = $('footer').outerHeight(true))
  //     }
  //   }
  // });

// // this is a very rudimentary multifaceted search implementation.
// // Should be considered for demo/prototype purposes only.
// // Still in progress -- doesn't quite work yet.

var datesArray = [], genresArray = [], locationsArray = [];


var updateEventList = function(array) {
  // first we hide everything.
  $('.event-list-item').addClass('hidden-event');
  // make sure the array isn't empty, if it is we want to show everything.
  if (_.isEmpty(array)) {
    $('.event-list-item').removeClass('hidden-event');
  } else {

    // go through the event list and find split the arrays.

    $('.event-list-item').each(function() {
      var el = $(this);
      var tmpArray = el.data('date').split(',');
      console.log("Tmp Array: " + tmpArray);
      console.log("Array: " + array);
      var toShow =  _.intersection(array, tmpArray);
      console.log("To Show: " + toShow);
      if(! _.isEmpty(toShow)) {
        el.removeClass('hidden-event');
      }
    });
  }
};


});
