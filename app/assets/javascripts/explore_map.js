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
    if (expBlockRequired) {
      commonInitialization(data, ".top-from-explorizers");
    } else {
      commonInitializationForExploreMap(data);
    }
  });
}

function commonInitializationForExploreMap(data) {
  setExperienceInfowindowForGlobalMap(data);
}

function makeExperiencesSortable() {
  var panelList = $('#draggablePanelList');
  if (panelList.hasClass('ui-sortable-disabled')) {
    panelList.sortable('enable');
  }
  panelList.sortable({
  // Only make the .panel-heading child elements support dragging.
  // Omit this to make the entire <li>...</li> draggable.
    handle: '.panel-heading',
    update: function() {
      $('.panel', panelList).each(function(index, elem) {
        var $listItem = $(elem),
          newIndex = $listItem.index(); // Persist the new indices.
      });
    }
  });
  addBoxShadowEffectWhileDraggingBox();
}

function preventExperiencesFromBeingSortable() {
    if ($('#draggablePanelList').hasClass('ui-sortable')) {
      $('#draggablePanelList').sortable('disable');
    }
}

function addBoxShadowEffectWhileDraggingBox() {
  $('.panel-heading').on('mousedown', function(){
    $(this).parent().parent().css('box-shadow', '2px 2px 1px 1px rgba(0, 0, 0, 0.5)');
    $(document).on('mouseup', function(){
      $('.panel').css('box-shadow', '1px 1px 1px 1px rgba(0, 0, 0, 0.1)');
      $(this).unbind('mouseup');
    });
  });
}

// TODO: put all common function to map interaction in a global map js file and keep specifi file for specific functions