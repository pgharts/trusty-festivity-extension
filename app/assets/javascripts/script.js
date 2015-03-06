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

  var popOverSettings = {
      placement: 'top',
      container: 'body',
      html: true,
      title: 'All Dates and Times',
      selector: '.btn-popover', //Sepcify the selector here
      content: "<div><ul class='list-unstyled'><li>Friday, June 6, 12:00 pm - 9 pm</li><li>Saturday, June 7, 12:00 pm - 9 pm</li><li>Sunday, June 9, 12:00 pm - 9 pm</li><li>Monday, June 12, 12:00 pm - 9 pm</li></ul></div>"
  }

  $('body').popover(popOverSettings);

// init popovers
$("[data-toggle=popover]").popover();

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


var updateSortingArray = function() {
  if ($(this).hasClass('active')) {
    datesArray = _.without(datesArray, $(this).data('sort'));
  } else {
    datesArray.push($(this).data('sort'));
  }

  $(this).toggleClass('active');
  updateEventList(datesArray);
  $( ".current-filters ul" ).empty();

  $.each(datesArray, function(index, value) {
    var prettyValue = value.replace('-', ', ');
    var prettyValue = prettyValue.replace('-', ' ');

    $( ".current-filters ul" ).append( "<li class='" + value + "'>" + prettyValue + " </li>" );
  });


};

  $('.event-filter-bar .date-filters input[type="checkbox"]').on('click', updateSortingArray);


});
