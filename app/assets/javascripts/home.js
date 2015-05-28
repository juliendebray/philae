$(document).on('ready', function() {
  FadeIndexonScroll('.fader');
});


function FadeIndexonScroll(selector) {
  var divs = $(selector);
  $(window).on('scroll', function() {
    var st = $(this).scrollTop();
    divs.css({ 'opacity' : (1 - st/450) });
  });

  // $(window).scroll(function() {
  //   if ($(this).scrollTop()>450) {
  //     $('.fader').fadeOut();
  //   } else {
  //     $('.fader').show();
  //   }
  // });
}
