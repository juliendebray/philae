function initializeMapSearchBar(id) {

  var input = document.getElementById(id);
  var defaultBounds = new google.maps.LatLngBounds(
      new google.maps.LatLng(-90, 180),
      new google.maps.LatLng(90, 180)
  );

  var options = {
    bounds: defaultBounds,
    types: ['geocode']
  };

  var autocomplete = new google.maps.places.Autocomplete(input, options);

  // var map = handler.getMap();

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    var place =  this.getPlace();
    if(typeof place.geometry !== "undefined") {
      moveMapAccordinglyToViewport(place);
    } else if (place.name !== "undefined") {
      var geocoder = new google.maps.Geocoder();
      geocoder.geocode( { 'address': place.name}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          moveMapAccordinglyToViewport(results[0]);
        } else {
          alert('Geocode was not successful for the following reason: ' + status);
        }
      });
    } else {
        alert('Something went wrong :(');
    }
  });
}

function moveMapAccordinglyToViewport(result) {
  var map = handler.getMap();
  if (result.geometry.viewport) {
    map.fitBounds(result.geometry.viewport);
  } else {
    map.setCenter(result.geometry.location);
  }
}
