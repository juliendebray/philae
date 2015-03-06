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

  var map = handler.getMap();

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    var place =  this.getPlace();
    if(typeof place.geometry !== "undefined") {
      moveMapAccordinglyToViewport(place, map);
    } else if (place.name !== "undefined") {
      var geocoder = new google.maps.Geocoder();
      geocoder.geocode( { 'address': place.name}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          moveMapAccordinglyToViewport(results[0], map);
        } else {
          alert('Geocode was not successful for the following reason: ' + status);
        }
      });
    } else {
        alert('Something went wrong :(');
    }
  });
}

function moveMapAccordinglyToViewport(result, map) {
  if (result.geometry.viewport) {
    // console.log('un')
    map.fitBounds(result.geometry.viewport);


    // console.log('bounds de acc to view:');
    // console.log(map.getBounds());

  } else {
    // console.log('deux')
    map.setCenter(result.geometry.location);
  }
}
