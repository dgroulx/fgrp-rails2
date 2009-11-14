var searchMap = null;
var searchGeoCoder = null;

function InitSearchMap()
{
	searchMap = new GMap2($("#search-map")[0]);
	searchGeoCoder = new GClientGeocoder();
	searchGeoCoder.getLatLng("Grand Rapids,MI", function(pLatLng){
		searchMap.setCenter(pLatLng,10);	
	});
};

function ToggleSearchWindow(){
	var theWindow = $("#search-window");
	theWindow.slideToggle();
};
function ShowSearchWindow(){
	var theWindow = $("#search-window");
	theWindow.slideDown();
};
function HideSearchWindow(){
	var theWindow = $("#search-window");
	theWindow.slideUp();
};

InitSearchMap();
