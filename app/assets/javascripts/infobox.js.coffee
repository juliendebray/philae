class @InfoBoxBuilder extends Gmaps.Google.Builders.Marker # inherit from base builder
  # override method
  create_infowindow: ->
    return null unless _.isString @args.infowindow

    boxText = document.createElement("div")
    boxText.setAttribute("class", 'infobox-container') #to customize
    boxText.innerHTML = @args.infowindow
    @infowindow = new InfoBox(@infobox(boxText))

  infobox: (boxText)->
    content: boxText,
    alignBottom: true,
    pixelOffset: new google.maps.Size(-140, -40),
    infoBoxClearance: 20,
    closeBoxMargin: "12px 2px 2px 2px"
    boxStyle:
      width: "280px",
      opacity: 0.95,
      infoBoxClearance: new google.maps.Size(1, 1)
