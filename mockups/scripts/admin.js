var map = null;
var geoCoder = null;
var marker = null;



function SetProfileMapCenter(pLatLng)
{
	if(marker===null)
	{
		var theIcon = new GIcon();
		theIcon.image = "images/Tree-20x20.png";
		theIcon.shadow = "images/Tree-shadow.png";
		theIcon.iconSize = new GSize(20,20);
		theIcon.shadowSize = new GSize(69,20);
		//marker = new GMarker(pLatLng,{icon:theIcon});
		marker = new GMarker(pLatLng);
		map.addOverlay(marker);
	}
	marker.setLatLng(pLatLng);

	map.setCenter(pLatLng,12);
};
function RemoveAmenity(e)
{
	var theRemoveLink = $(this);
	var theAmenity = theRemoveLink.parents(".amenity");
	var theAmenities = theAmenity.parents("#amenities-list");
	theAmenity.remove();
	if(theAmenities.find("li").length==0)
	{
		theAmenities.html("Nothing selected yet.");
	}
	
	return false;
}
function SetupAmenities()
{
	var amenities = "Benches,Basketball Court,Restrooms,Soccer Field,Football Field,Baseball Diamond,Playground,Monument".split(",");
	$("#amenities_input").autocomplete(amenities);
	
	$("#amenities_input").result(function(event, data, formatted) {
		if(data)
		{
			if($("#amenities-list li").length==0)
			{
				$("#amenities-list").empty();
			}
			var theAmenity = $("<li class='amenity'>"+data+"</li>").appendTo("#amenities-list");
			$("<a href=''>Remove</a>").appendTo(theAmenity).click(RemoveAmenity);
			$("#amenities_input").val("");
		}
	});
};
function SetupContact()
{
	var InfoClick = function(e){
		var theInfo = $(this);
		theInfo.unbind("click");
		//get value
		var oldValue = theInfo.html();
		//create input & insert value
		theInfo.html("<input type='text' class='contact-modify textbox' value='"+oldValue+"'/>");
		//Add Update button, apply click event
		$("<a href='javascript:void()'>Update</a>").appendTo(theInfo).click(function(e){
			var theValue = theInfo.find(".contact-modify").val();
			theInfo.html(theValue);
		});
		//Add Cancel Button, apply click event
		$("<a href='javascript:void()'>Cancel</a>").appendTo(theInfo).click(function(e){
			theInfo.html(oldValue);
		});
	};
	$(".contact-info .info").click(InfoClick);
};
function KeepUpdateButtonCentered()
{
	var theButton = $("#update-button");
	
};
function Init()
{
	var $address = $("#park-address1");
	map = new GMap2($("#park-map")[0]);
	geoCoder = new GClientGeocoder();
	geoCoder.getLatLng($address.val(), SetProfileMapCenter);	
	$("#park-address-update").click(function(e){
		geoCoder.getLatLng($address.val(),SetProfileMapCenter);		
	});
	$("#add-flicker").click(function(e){
		//hide add-flickr button
		$(this).hide();
		//show the flickr form
	});
	
	SetupAmenities();
	SetupContact();
	KeepUpdateButtonCentered();
};


Init();