(function() {

  var GRAND_RAPIDS = [42.935, -85.65];
  var DEFAULT_ZOOM = 10;

  jQuery(function($) {
    if($("#map").length==0)
    {
      return;
    }
    var searchFieldElement = $("#search-fields");
    var INFO_WINDOW_TEMPLATE = $('<div><h1><a class="name"></a></h1><p class="address"></p></div>');
    
    var map = new GMap2(document.getElementById("map"));
    map.setUIToDefault();
    window.map = map;
    
    function preparePark() {
      this.latlng = new GLatLng(this.latitude, this.longitude);
      this.marker = new GMarker(this.latlng);

      var infoWindowData = {
        name: { innerHTML: this.name, "@href": this.url },
        address: this.address
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
        appendTo(searchFieldElement).
        val("all").
        change();
    }
    
    function getBounds(data)
    {
      var bounds = new GLatLngBounds();;
      $.each(data.parks, function() {
        bounds.extend(this.latlng);
      });
      return bounds;
    }

    function processData(data) {
      $.each(data.parks, preparePark);
      
      var bounds = getBounds(data);
      
      map.setCenter(bounds.getCenter(), map.getBoundsZoomLevel(bounds)); 
      populateAmenities(data);
    }

    // Get park data on page load
    var retrievedData = {parks: false, amenities:false};
    function getJSONData(pCallback)
    {
      $.getJSON("/parks.json",function(retrievedData){
        if (retrievedData.parks.length > 0) {
          processData(retrievedData);
        } else {
          map.setCenter(new GLatLng(GRAND_RAPIDS[0], GRAND_RAPIDS[1]), DEFAULT_ZOOM);
        }
        if(typeof(pCallback)!="undefined")
          pCallback(retrievedData);
      });
    }
    getJSONData();
    
    $("body.parks.show a.find-more-parks").click(function(){
      var searchWindow = $("body.parks.show .search-window");
      var showText = "...find more parks!";
      var hideText = "i'm done searching";
      var link = $(this);
      searchWindow.toggleClass("show-map");
      
      if(searchWindow.hasClass("show-map"))
      {
        link.html(hideText);
        /*height:auto;
        overflow:auto;*/
        searchWindow.animate({
          height:"420px",
          overflow:"auto"
        });
      }
      else{
        link.html(showText);
        searchWindow.animate({
          height:"0px",
          overflow:"hidden"
        });
      }
      return false;
    });
    
  });

})();
