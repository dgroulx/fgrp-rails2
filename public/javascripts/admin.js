
$(document).ready(function() {	
  (function() {
    var adminArea = $("body.parks.admin"); //refactor this out
    var address = adminArea.find(".address:first");
  
    function logMapMessage(pMessage)
    {
      adminArea.find(".message:first").html(pMessage);
    }
    function updateLatLngInputs(pGLatLng)
    {
      adminArea.find(".latitude:first").val(pGLatLng.lat());
      adminArea.find(".longitude:first").val(pGLatLng.lng());
    }
    function updateMap(pSelector,pAddress,pPlotmarker,pUpateLatLng)
    {
      var adminMap = new GMap2($(pSelector)[0]);
      var geoCoder = new GClientGeocoder();
    
      if(pAddress.length==0)
      {
        pAddress = "Grand Rapids,MI";
      }
    
      geoCoder.getLatLng(pAddress,function(pLatLng){
        if(pLatLng===null)
        {
          logMapMessage("Address not found.");
          return;
        }
        else
        {
          adminMap.setCenter(pLatLng, 10);
          adminMap.clearOverlays();
          if(pUpateLatLng)
            updateLatLngInputs(pLatLng);
          if(pPlotmarker)
          {
            var marker = new GMarker(pLatLng);
            adminMap.addOverlay(marker);
          }
        }
      });
    }
  
    $('body.parks.admin .update-address:first').click(function() {
      var geoCoder = new GClientGeocoder();
      geoCoder.getLatLng(address.val(),function(pLatLng){
        if(pLatLng===null)
          logMapMessage("Address could not be found");
        else
        {
          logMapMessage("Address found successfully.");
          updateMap("#admin-map",address.val(),true,true);
        }
      }); 
      return false;
    });
  
  
    if($("#admin-map").length>0)
    {
      if(adminArea.find(".latitude").val().length>0 && adminArea.find(".longitude").val().length>0)
        updateMap("#admin-map",address.val(),true,true);
      else
        updateMap("#admin-map","Grand Rapids, MI",false,false);
    }
  })();
    



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







