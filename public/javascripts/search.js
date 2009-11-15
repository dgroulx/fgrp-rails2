(function() {

  var GRAND_RAPIDS = [42.935, -85.65];
  var DEFAULT_ZOOM = 10;
  var array = [];
  array[80] = 1;

  jQuery(function($) {
    if($("#map").length==0)
    {
      return;
    }
    var searchFieldElement = $("#search-fields");
    var INFO_WINDOW_TEMPLATE = $('<div><h1 class="name"></h1><p class="address"></p><a class="link">More info</a></div>');
    
    var map = new GMap2(document.getElementById("map"));
    map.setUIToDefault();
    window.map = map;
    
    function preparePark() {
      this.latlng = new GLatLng(this.latitude, this.longitude);
      this.marker = new GMarker(this.latlng);

      var infoWindowData = {
        name: this.name,
        address: this.address,
        link: {"@href": this.url }
      };
      
      GEvent.addListener(this.marker, "click", function() {
        this.openInfoWindow(INFO_WINDOW_TEMPLATE.expand(infoWindowData)[0]);
      });
    }

    function displayParks(parks) {
      map.clearOverlays();
      $.each(parks, function() {
        map.addOverlay(this.marker);
      });
    }
    
    function makeParkFilter(data) {
      var currentlySelected;
      
      return function() {
        var selectedAmenity = $(this).val();
        if (selectedAmenity == currentlySelected) return;
        currentlySelected = selectedAmenity;
        
        if (selectedAmenity == "all") {
          displayParks(data.parks);
        } else {
          var index = parseInt(selectedAmenity, 10);
          var matchingParks = $.grep(data.parks, 
            function(park) { return park.amenities[index]; });
          displayParks(matchingParks);
        }
      }
    }
    
    function populateAmenities(data) {
      var amenities = data.amenities;
      var filterParks = makeParkFilter(data);
      
      var options = $.merge(
        [{"@value": "all", innerHTML: "All Parks"}],
        $.map(amenities, function(amenity, index){ 
          return {"@value": index, "innerHTML": amenity}; }));
        
      var dropDown = $('<select><option /></select>').
        expand(options).
        click(filterParks).
        change(filterParks).
        appendTo(searchFieldElement);
    }

    function processData(data) {
      $.each(data.parks, preparePark);
      
      var bounds = new GLatLngBounds();
      $.each(data.parks, function() {
        bounds.extend(this.latlng);
      });
      
      map.setCenter(bounds.getCenter(), map.getBoundsZoomLevel(bounds)); 
      displayParks(data.parks);
      populateAmenities(data);
    }

    // Get park data on page load
    //this area below needs rewriting.
    var retrievedData = {parks: false, amenities:false};
    $.getJSON("/parks.json",function(retrievedData){
      if (retrievedData.parks.length > 0) {
        processData(retrievedData);
      } else {
        map.setCenter(new GLatLng(GRAND_RAPIDS[0], GRAND_RAPIDS[1]), DEFAULT_ZOOM);
      }
    });
    
    $("body.parks.show a.find-more-parks").click(function(){
      var searchWindow = $("body.parks.show .search-window");
      var showText = "...find more parks!";
      var hideText = "i'm done searching";
      
      if(searchWindow.css("display") == "none")
      {
        //not currently shown, show and change text
        searchWindow.slideDown();
        $(this).html(hideText);
      }
      else
      {
        //shown, hide and change text
        searchWindow.slideUp();
        $(this).html(showText);
      }
      return false;
    });
    
  });

})();
