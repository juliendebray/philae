var handler;
var markers = {};

function initializeFilterButtons(trip_id, expBlockRequired) {
  SetAndRemoveButtonActiveClassOnClick(trip_id, expBlockRequired);
}

function removeFiltersActiveClass() {
  $('a.category-btn.active').removeClass('active');
}

function SetAndRemoveButtonActiveClassOnClick(trip_id, expBlockRequired) {
  $('a.category-btn').on('click', function() {
    if ($(this).hasClass('active')) {
      $(this).removeClass('active');
    } else {
      $(this).addClass('active');
    }
    requestDataFromAPI(trip_id, collectUserChoice(), expBlockRequired);
  });
}

function collectUserChoice() {
  var categories = [];
  var activeButton = $('a.category-btn.active');
  $.each(activeButton, function(index, value) {
    categories.push(value.id);
  });
  return {'categories': categories }
}

function requestDataFromAPI(trip_id, dataToSend, expBlockRequired) {
  var url = ""
  if (expBlockRequired) {
    url = "/trips/" + trip_id + "/search_results_with_block";
  } else {
    url = "/trips/" + trip_id + "/search_results";
  }
  $.getJSON(url,  dataToSend, function( data ) {
    handler.removeMarkers(markers);
    markers = handler.addMarkers(data);
    commonInitializationForExploreMap(data);
  });
}

function commonInitializationForExploreMap(data) {
  setExperienceInfowindowForGlobalMap(data);
}

// TODO: put all common function to map interaction in a global map js file and keep specifi file for specific functions