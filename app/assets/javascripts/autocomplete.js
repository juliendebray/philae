function initializeAutocomplete(id, setLatAndLng) {
  var defaultBounds = new google.maps.LatLngBounds(
    new google.maps.LatLng(-90, 180),
    new google.maps.LatLng(90, 180));
  var input = document.getElementById(id);

  var options = {
    bounds: defaultBounds,
    types: ['geocode']
  };

  if (input) {
    var autocomplete = new google.maps.places.Autocomplete(input, options);
    if (setLatAndLng) {
      google.maps.event.addListener(autocomplete, 'place_changed', onPlaceChanged);
    } else {
    google.maps.event.addListener(autocomplete, 'place_changed');
    }
  }
}

function onPlaceChanged() {
  var place = this.getPlace();
  var lat = place.geometry.location.lat();
  var lng = place.geometry.location.lng();
  if ($('#trip_latitude').length + $('#trip_longitude').length > 1) {
    $('#trip_latitude').attr('value', lat);
    $('#trip_longitude').attr('value', lng);
  } else if ($('#experience_latitude').length + $('#experience_longitude').length > 1) {
    $('#experience_latitude').attr('value', lat);
    $('#experience_longitude').attr('value', lng);
  } else if ($('#trip_comment_latitude').length + $('#trip_comment_longitude').length > 1) {
    $('#trip_comment_latitude').attr('value', lat);
    $('#trip_comment_longitude').attr('value', lng);
  }
}

if(typeof google !== "undefined") {
  google.maps.event.addDomListener(window, 'load', function() {
    initializeAutocomplete('experience_address', true);
    initializeAutocomplete('trip_comment_address', true);
    initializeAutocomplete('trip_query', true);
  });
}