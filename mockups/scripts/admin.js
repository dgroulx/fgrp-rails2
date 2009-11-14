var map = null;
var geoCoder = null;
function SetCenter(pLatLng)
{
	map.setCenter(pLatLng,12);
};
function Init()
{
	var $address = $("#park-address1");
	map = new GMap2($("#park-map")[0]);
	geoCoder = new GClientGeocoder();
	geoCoder.getLatLng($address.val(), SetCenter);	
	$("#park-address-update").click(function(e){
		geoCoder.getLatLng($address.val(),SetCenter);		
	});
	$("#add-flicker").click(function(e){
		//hide add-flickr button
		$(this).hide();
		//show the flickr form
		
	});
};

Init();