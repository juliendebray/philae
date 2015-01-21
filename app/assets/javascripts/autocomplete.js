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
  // if (id == 'trip_query') {
    var place = this.getPlace();
    $('#trip_latitude').attr('value', place.geometry.location.k);
    $('#trip_longitude').attr('value', place.geometry.location.D);

    console.log(place);  // Uncomment this line to view the full object returned by Google API.

    // for (var i in place.address_components) {
    //   var component = place.address_components[i];
    //   for (var j in component.types) {  // Some types are ["country", "political"]
    //     var type_input = document.getElementById(component.types[j]);
    //     if (type_input) {
    //       type_input.value = component.long_name;
    //     }
    //   }
    // }
  // }
}

if(typeof google !== "undefined") {
  google.maps.event.addDomListener(window, 'load', function() {
    initializeAutocomplete('experience_address', false);
    initializeAutocomplete('trip_comment_address', false);
    initializeAutocomplete('trip_query', true);
  });
}