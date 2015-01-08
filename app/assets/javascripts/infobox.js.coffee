class @InfoBoxBuilder extends Gmaps.Google.Builders.Marker # inherit from base builder
  # override method
  create_infowindow: ->
    return null unless _.isString @args.infowindow

    boxText = document.createElement("div")
    boxText.setAttribute("class", 'infobox-container') #to customize
    boxText.innerHTML = @args.infowindow
    @infowindow = new InfoBox(@infobox(boxText))

  infobox: (boxText)->
    content: boxText
    ,disableAutoPan: true
    ,pixelOffset: new google.maps.Size(-140, -40)
    ,alignBottom: true
    ,zIndex: null
    ,closeBoxURL: ""
    ,boxStyle: {
      width: "280px"
      ,opacity: 1
    }
    ,infoBoxClearance: new google.maps.Size(10, 10)
    ,isHidden: false
    ,pane: "floatPane"
    ,enableEventPropagation: false


