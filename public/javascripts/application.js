$(document).ready(function() {
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
  
  $('body.parks.admin .amenity .delete').each(function() {
    $(this).click(function() {
      $(this).parent().siblings('input[type=hidden]:first').attr('value', 1);
      $(this).parent().parent().hide();
      return false;
    });
  });
  
  
  $('.flickr-pool-slideshow').each(function() {
    var element = $(this);
    var key = "40343c1f16327beb5c9adfd73caec372";
    var group_id = element.attr("data-groupid");
    var api_method = "flickr.groups.pools.getPhotos&group_id=" + group_id;

    var callback = function(data) {
      console.log(data);
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
});