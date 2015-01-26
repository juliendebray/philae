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
    if ($('#trip_latitude').length + $('#trip_longitude').length > 1) {
      $('#trip_latitude').attr('value', place.geometry.location.k);
      $('#trip_longitude').attr('value', place.geometry.location.D);
    } else if ($('#experience_latitude').length + $('#experience_longitude').length > 1) {
        $('#experience_latitude').attr('value', place.geometry.location.k);
        $('#experience_longitude').attr('value', place.geometry.location.D);
    } else if ($('#trip_comment_latitude').length + $('#trip_comment_longitude').length > 1) {
        $('#trip_comment_latitude').attr('value', place.geometry.location.k);
        $('#trip_comment_longitude').attr('value', place.geometry.location.D);
    }

    // console.log(place);  // Uncomment this line to view the full object returned by Google API.

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
    initializeAutocomplete('experience_address', true);
    initializeAutocomplete('trip_comment_address', true);
    initializeAutocomplete('trip_query', true);
  });
}