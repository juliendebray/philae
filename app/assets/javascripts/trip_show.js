function setClassActiveOnLink(a) {
  var target = $(a).attr('href');
  $('li.active').removeClass('active');
  $('a[href=' + target + ']', 'li').parent().first().addClass('active');
}