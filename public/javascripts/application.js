$(document).ready(function() {
  $('.flickr-pool-slideshow').each(function() {
    var element = $(this);
    var key = "40343c1f16327beb5c9adfd73caec372";
    var group_id = element.attr("data-groupid");
    var api_method = "flickr.groups.pools.getPhotos&group_id=" + group_id;

    var callback = function(data) {
      if (data.stat == "ok") {
        var data = $.map(data.photos.photo, function(photo) {
          return { 
            '$img': { "@src": "http://farm" + photo.farm + ".static.flickr.com/" + photo.server +"/" + photo.id + "_" + photo.secret + "_m.jpg" }
          };
        });

        element.
          append( $("<ul><li><img /></li></ul>").expand(data)).
          find("ul").innerfade();
      }
    }

    $.getJSON("http://www.flickr.com/services/rest/?jsoncallback=?&format=json&per_page=10&api_key=" + key + "&method="+ api_method, callback);
  });
  
  
  $(".simple_map[data-latitude][data-longitude]").each(function() {
    var el = $(this);
    
    var map = new GMap2(this);
    var parkLatLng = new GLatLng(el.attr("data-latitude"), el.attr('data-longitude'));
    map.setCenter(parkLatLng, el.attr("data-zoom") || 14);
    map.addOverlay(new GMarker(parkLatLng))
  });
});