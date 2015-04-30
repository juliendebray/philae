function changeDropDownMenuTitle() {
  $(".dropdown-menu.dropdown-titles li a").click(function(){
    var selText = $(this).text();
    $(this).parents('.btn-group').find('.dropdown-toggle').html(selText+' <span class="caret"></span>');
  });
}

function SetAndRemoveButtonActiveClassOnClick() {
  $('a.category-btn').on('click', function() {
    if ($(this).hasClass('active')) {
      $(this).removeClass('active');
    } else {
      $(this).addClass('active');
    }
  });
  $('a.sort-by-btn').on('click', function() {
    if ($(this).hasClass('active')) {
      return
    } else {
      $(this).parents('.btn-group').find('.active').removeClass('active');
      $(this).addClass('active');
    }
  });
}

function collectUserChoice() {
  var sortBy = $('a.sort-by-btn.active').prop('id');
  var categories = [];
  var activeButton = $('a.category-btn.active');
  $.each(activeButton, function(index, value) {
    categories.push(value.id);
  });
  return { 'sortBy': sortBy, 'categories': categories }
}

function requestDataFromAPI(trip_id, dataToSend) {
  var url = "/trips/" + trip_id + "/search_results"
  $.getJSON(url, dataToSend, function( data ) {
    console.log(data);
  });
}

