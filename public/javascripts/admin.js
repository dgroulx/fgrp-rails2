
$(document).ready(function() {	
  function logMapMessage(pMessage)
  {
    var adminArea = $("body.parks.admin");
    adminArea.find(".message").html(pMessage);
  }
  
  function updateMap(pSelector,pAddress)
  {
    var adminArea = $("body.parks.admin");
    var adminMap = new GMap2($(pSelector)[0]);
    var address = $("body.parks.admin .address:first");
    var geoCoder = new GClientGeocoder();
    
    if(pAddress.length==0)
    {
      //default value--certainly not the best way to do this.
      pAddress = "Grand Rapids,MI";
      address.val(pAddress);
    }
    
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
        adminArea.find(".latitude").val(pLatLng.lat());
        adminArea.find(".longitude").val(pLatLng.lng());
        adminMap.addOverlay(marker);  
      }
    });
  }
  
  $('body.parks.admin .update-address:first').click(function() {
    var adminArea = $("body.parks.admin");
    var address =  adminArea.find(".address:first");
    var geoCoder = new GClientGeocoder();
    geoCoder.getLatLng(address.val(),function(pLatLng){
      if(pLatLng===null)
        logMapMessage("Address could not be found");
      else
      {
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







