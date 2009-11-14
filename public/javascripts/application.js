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
});