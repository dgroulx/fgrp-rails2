
$(document).ready(function() {	

  (function(element, address) {
    var map = new GMap2(element.find(".admin-map")[0]);
    var geoCoder = new GClientGeocoder();
    
    function centerMap(latLng) {
      map.setCenter(latLng, 10);
    }
    
    function updateLatLng(latlng) {
      element.find(".latitude").val(latlng.lat());
      element.find(".longitude").val(latlng.lng());
      
      map.clearOverlays();
      centerMap(latlng);
      map.addOverlay(new GMarker(latlng));
    }
    
    function updateLatLngFromForm() {
      var lat = element.find(".latitude").val();
      var lng = element.find(".longitude").val();
      var latlng = new GLatLng(lat, lng);
      element.find(".message").html("");
      updateLatLng(latlng);
      return false;
    }
    
    
    function geolocate(addr, callback) {
      geoCoder.getLatLng(addr, function(pLatLng){
        if(pLatLng === null){
          element.find(".message").html("Address could not be found");
        } else {
          element.find(".message").html("Address found successfully.");
          callback(pLatLng)
        }
      }); 
    }
    
    function updateLatLngFromAddress() {
      geolocate(address.val(), updateLatLng)
      return false;
    }
    
    element.
      find(".update-address").
      click(updateLatLngFromAddress)
    
    element.
      find(".update-map").
      click(updateLatLngFromForm)
    
    if (/^\s*$/.test(element.find(".latitude").val()) || /^\s*$/.test(element.find(".longitude").val()))
      geoCoder.getLatLng("Grand Rapids, MI", centerMap);
    else
      updateLatLngFromForm();
    
  })($("body.parks.admin .location"), $("body.parks.admin input.address"));


  // amenities on teh parks admin
  (function() {
    var amenity_template = $('body.parks.admin .amenities .template').remove().html();
    var amenity_counter = $('body.parks.admin .amenities .amenity').length;

    $('body.parks.admin .add_amenity').each(function() {
      $(this).click(function() {
        var this_template_content = amenity_template.replace(/NEW_RECORD/g, amenity_counter);
        $('body.parks.admin .amenities').append(this_template_content);
        amenity_counter++;
        return false;
      });
    });

    $('body.parks.admin .amenity a.delete').
      live('click', function() {
        $(this).parents(".amenity").
          hide().
          find('input[name*=_delete]').
            attr('value', 1);
        return false;})
  })();
  
});







