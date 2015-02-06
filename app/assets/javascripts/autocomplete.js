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
    console.log('entre dans le place changed');
    var place = this.getPlaces();
    console.log(place);
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