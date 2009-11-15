class PagesController < ApplicationController
  def explore
    @categorized_parks = Park.all.categorize {|park| park.section}
  end

end
