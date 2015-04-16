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
  console.log(this);
  console.log(place);
  if (!place.geometry) {
    return;
  }
  var lat = place.geometry.location.lat();
  var lng = place.geometry.location.lng();
  if ($('#trip_latitude').length + $('#trip_longitude').length > 1) {
    $('#trip_latitude').attr('value', lat);
    $('#trip_longitude').attr('value', lng);
    $('#trip_country_code').attr('value', $(place.address_components).get(-1).short_name);
    if(place.geometry.viewport) {
      $('#trip_vp_ne_lat').attr('value', place.geometry.viewport.getNorthEast().lat());
      $('#trip_vp_ne_lng').attr('value', place.geometry.viewport.getNorthEast().lng());
      $('#trip_vp_sw_lat').attr('value', place.geometry.viewport.getSouthWest().lat());
      $('#trip_vp_sw_lng').attr('value', place.geometry.viewport.getSouthWest().lng());
    }
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