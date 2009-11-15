
$(document).ready(function() {	
  function logMapMessage(pMessage)
  {
    var adminArea = $("body.parks.admin");
    adminArea.find(".message").html(pMessage);
  }
  
  function updateMap(pSelector,pAddress)
  {
    var adminMap = new GMap2($(pSelector)[0]);
    var address = $("body.parks.admin .address:first");
    var geoCoder = new GClientGeocoder();

    geoCoder.getLatLng(address.val(),function(pLatLng){
      if(pLatLng===null)
      {
        logMapMessage("Address not found.");
        return;
      }
      else
      {
        adminMap.setCenter(pLatLng, 10);
        adminMap.clearOverlays();
        var marker = new GMarker(pLatLng);
        adminMap.addOverlay(marker);  
      }
    });
  }
  
  $('body.parks.admin .update-address:first').click(function() {

    var address =  adminArea.find(".address:first");
    var geoCoder = new GClientGeocoder();
    geoCoder.getLatLng(address.val(),function(pLatLng){
      if(pLatLng===null)
        logMapMessage("Address could not be found");
      else
      {
        adminArea.find(".latitude").val(pLatLng.lat());
        adminArea.find(".longitude").val(pLatLng.lng());
        logMapMessage("Address found successfully.");
        updateMap("#adminMap",address.val());
      }
    }); 
    return false;
  });
  
  if($("#admin-map").length>0)
  {
    var address = $("body.parks.admin .address:first");
    updateMap("#admin-map",address.val());
  }
  
});







