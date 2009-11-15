  var GRAND_RAPIDS = [42.935, -85.65];
  var array = [];
  array[80] = 1;

  jQuery(function($) {
    var searchFieldElement = $("#search-fields");
    var INFO_WINDOW_TEMPLATE = $('<div><h1 class="name"></h1><p class="address"></p><a class="link">More info</a></div>');
    
    var map = new GMap2(document.getElementById("map"));
    window.map = map;
    map.setCenter(new GLatLng(GRAND_RAPIDS[0], GRAND_RAPIDS[1]), 10);
    
		function preparePark() {
      this.latlng = new GLatLng(this.point[0], this.point[1]);
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
          return {"@value": index, "innerHTML": amenity.name}; }));
        
      var dropDown = $('<select><option /></select>').
        expand(options).
        click(filterParks).
        change(filterParks).
        appendTo(searchFieldElement);
    }

    // Simulated json callback
    function dataArrived(data) {
      $.each(data.parks, preparePark);
      
      var bounds = new GLatLngBounds();
      $.each(data.parks, function() {
        bounds.extend(this.latlng);
      });
      map.setCenter(bounds.getCenter(), map.getBoundsZoomLevel(bounds)); 
      displayParks(data.parks);
      populateAmenities(data);
    }
   
    // FAKE OUT A AJAX CALL
    //dataArrived(getData);

		// Get park data on page load
		var getData = {parks: false, amenities:false};
		$.getJSON('/amenities.json', function(amenities) {
			getData.amenities = amenities;
			dataArrived(getData);
		});
		$.getJSON("/parks.json",function(parks){
			getData.parks = parks;
			dataArrived(getData);
		});
	
  });