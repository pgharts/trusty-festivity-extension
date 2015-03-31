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


});
